//
//  HomeViewController.swift
//  Forecasty
//
//  Created by Gonçalo Neves on 15/06/2021.
//

import UIKit
import OSLog

class HomeViewController: UIViewController {

    // MARK: Properties

    let viewModel: HomeViewModel

    // MARK: - UI

    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        
        let layout = UICollectionViewFlowLayout()
        let width = view.frame.width / 2 - (2 * viewModel.horizontalConstraintConstant)
        layout.itemSize = CGSize(width: width, height: width)

        return layout
    }()

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refreshControl.tintColor = .lightGray
        return refreshControl
    }()

    lazy var collectionView: UICollectionView = { [weak self] in

        guard let self = self else {

            os_log("Error unwrapping countries retrieved from database", type: .error)

            return UICollectionView()
        }

        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: collectionViewLayout)
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(CountriesCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.refreshControl = refreshControl
        collectionView.addSubview(refreshControl)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    lazy var activityIndicator: UIActivityIndicatorView = {

        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    // MARK: Lifecycle

    init(viewModel: HomeViewModel) {

        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupInfo()
    }

    // MARK: Private methods

    private func setupInfo() {

        
        viewModel.fetchCellsInfo() { [weak self] result in

            if result {
                self?.collectionView.reloadData()
            } else {
                DispatchQueue.main.async {
                    self?.activityIndicator.startAnimating()
                }
                self?.viewModel.updateCellsInfo() {
                    DispatchQueue.main.async {
                        self?.activityIndicator.stopAnimating()
                    }
                    self?.collectionView.reloadData()
                }
            }
        }
    }

    private func setupUI() {

        navigationItem.title = viewModel.coordinator.session.constants.navigationItemTitle
        view.backgroundColor = .white

        view.addSubview(collectionView)
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate ([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: viewModel.horizontalConstraintConstant),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewModel.horizontalConstraintConstant),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -viewModel.horizontalConstraintConstant),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {

        viewModel.updateCellsInfo() { [weak self] in
            self?.collectionView.reloadData()
            refreshControl.endRefreshing()
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return viewModel.countriesData.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CountriesCollectionViewCell

        let country = self.viewModel.countriesData[indexPath.row]

        cell.nameLabel.text = country.name
        cell.regionLabel.text = country.region
        cell.capitalLabel.text = country.capital

        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectedCountry(indexPath)
    }
}
