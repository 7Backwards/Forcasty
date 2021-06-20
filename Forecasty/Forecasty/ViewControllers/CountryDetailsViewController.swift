//
//  CountryDetailsViewController.swift
//  Forecasty
//
//  Created by Gonçalo Neves on 20/06/2021.
//

import Foundation
import UIKit

class CountryDetailsViewModel {

    // MARK: Properties

    let country: Country
    let verticalStackViewSpacing: CGFloat = 20
    let containerViewCornerRadius: CGFloat = 20
    let outerConstraintConstant: CGFloat = 15
    let containerViewSize: CGFloat = 300

    init(country: Country) {
        self.country = country
    }
}

class CountryDetailsViewController: UIViewController {

    // MARK: Properties

    let viewModel: CountryDetailsViewModel

    // MARK: UI

    lazy var containerView: UIView = {
        let view = UIView()

        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        view.layer.shadowRadius = 5.0
        view.layer.shadowOpacity = 1.0
        view.layer.cornerRadius = viewModel.containerViewCornerRadius

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    lazy var verticalStackView: UIStackView = {

        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = viewModel.verticalStackViewSpacing
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy var popUpTitle: UILabel = {
        let label = UILabel()
        label.text = "countryDetails_Title".localized()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var capitalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var regionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var subRegionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var populationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var areaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Lifecycle

    init(viewModel: CountryDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: Private methods

    private func setupUI() {

        definesPresentationContext = true
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        view.addSubview(containerView)

        containerView.addSubview(popUpTitle)
        containerView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(capitalLabel)
        verticalStackView.addArrangedSubview(regionLabel)
        verticalStackView.addArrangedSubview(subRegionLabel)
        verticalStackView.addArrangedSubview(populationLabel)
        verticalStackView.addArrangedSubview(areaLabel)

        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: viewModel.containerViewSize),
            containerView.heightAnchor.constraint(equalToConstant: viewModel.containerViewSize),
            popUpTitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
            popUpTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            popUpTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -viewModel.outerConstraintConstant),
            verticalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: viewModel.outerConstraintConstant),
            verticalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -viewModel.outerConstraintConstant),
            
            verticalStackView.topAnchor.constraint(equalTo: popUpTitle.bottomAnchor, constant: viewModel.outerConstraintConstant),
            
            verticalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -viewModel.outerConstraintConstant)
        ])

        guard
            let name = viewModel.country.name,
            let capital = viewModel.country.capital,
            let region = viewModel.country.region,
            let subregion = viewModel.country.subregion
        else {
            return
        }
        nameLabel.text = "Name: \(name)"
        capitalLabel.text = "Capital: \(capital)"
        regionLabel.text = "Region: \(region)"
        subRegionLabel.text = "subRegion: \(subregion)"
        populationLabel.text = "Population: \(viewModel.country.population)"
        areaLabel.text = "Area: \(viewModel.country.area)"
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first

        if touch?.view == containerView {
            return
        }

        for view in containerView.subviews {
            if touch?.view == view {
                return
            }
        }

        dismiss(animated: true, completion: nil)
    }
}
