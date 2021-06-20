//
//  CountriesTableViewCell.swift
//  Forecasty
//
//  Created by Gonçalo Neves on 19/06/2021.
//

import Foundation
import UIKit

class CountriesCollectionViewCellModel {

    // MARK: Properties

    let cornerRadius: CGFloat = 10
    let shadowOpacity: Float = 1
    let shadowRadius: CGFloat = 5
    let shadowOffset: CGSize = CGSize(width: 0, height: 2)
    let outerConstraintConstant: CGFloat = 15

    init() {
        
    }
}

class CountriesCollectionViewCell: UICollectionViewCell {

    // MARK: Properties

    let viewModel = CountriesCollectionViewCellModel()

    // MARK: UI

    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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

    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private methods

    private func setupUI() {

        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = viewModel.shadowOffset
        layer.shadowRadius = viewModel.shadowRadius
        layer.shadowOpacity = viewModel.shadowOpacity
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        layer.backgroundColor = UIColor.clear.cgColor

        contentView.layer.masksToBounds = true
        layer.cornerRadius = viewModel.cornerRadius
        clipsToBounds = true

        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(capitalLabel)
        verticalStackView.addArrangedSubview(regionLabel)

        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: viewModel.outerConstraintConstant),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -viewModel.outerConstraintConstant),
            verticalStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: viewModel.outerConstraintConstant),
            verticalStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -viewModel.outerConstraintConstant)
        ])
    }
}
