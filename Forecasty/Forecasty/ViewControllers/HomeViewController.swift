//
//  HomeViewController.swift
//  Forecasty
//
//  Created by Gonçalo Neves on 15/06/2021.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: Properties

    let viewModel: HomeViewModel

    // MARK: - UI

    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width - (2 * viewModel.horizontalConstraintConstant), height: viewModel.cellHeight)
        layout.minimumInteritemSpacing = viewModel.collectionViewLayoutMinimumInteritemSpacing
        return layout
    }()

    lazy var collectionView: UICollectionView = {

        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: collectionViewLayout)
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(CountriesCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

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
        viewModel.updateCellsInfo() { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    private func setupUI() {

        navigationItem.title = viewModel.coordinator.session.constants.navigationItemTitle
        view.backgroundColor = .white

        view.addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate ([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: viewModel.horizontalConstraintConstant),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewModel.horizontalConstraintConstant),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -viewModel.horizontalConstraintConstant)
        ])
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
