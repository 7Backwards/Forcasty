//
//  MainCoordinator.swift
//  Forecasty
//
//  Created by Gonçalo Neves on 15/06/2021.
//

import Foundation
import UIKit

class MainCoordinator: CoordinatorProtocol {

    var presentedCoordinator: CoordinatorProtocol?
    var presentedViewController: UIViewController?
    var navigationController: UINavigationController
    var session: Session

    init(navigationController: UINavigationController, session: Session) {
        self.navigationController = navigationController
        self.session = session
    }

    func start() {

        let homeViewModel = HomeViewModel(coordinator: self, session: session)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        presentedViewController = homeViewController
        navigationController.pushViewController(homeViewController, animated: true)
    }

    func showCountryDetails(_ country: Country) {

        guard let presentedViewController = presentedViewController else {
            return
        }

        let countryDetailsViewModel = CountryDetailsViewModel(country: country)

        let countryDetailsViewController = CountryDetailsViewController(viewModel: countryDetailsViewModel)
        countryDetailsViewController.modalPresentationStyle = .overCurrentContext
        countryDetailsViewController.modalTransitionStyle = .crossDissolve
        presentedViewController.present(countryDetailsViewController, animated: true, completion: nil)
    }
}
