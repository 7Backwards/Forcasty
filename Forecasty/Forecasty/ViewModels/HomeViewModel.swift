//
//  HomeViewModel.swift
//  Forecasty
//
//  Created by Gonçalo Neves on 16/06/2021.
//

import CoreData
import Foundation
import UIKit

class HomeViewModel {

    let coordinator: MainCoordinator
    let session: Session
    var countriesData = [Country]()
    let cellHeight: CGFloat = 70
    let horizontalConstraintConstant: CGFloat = 15
    let collectionViewLayoutMinimumInteritemSpacing: CGFloat = 10

    init(coordinator: MainCoordinator, session: Session) {
        self.coordinator = coordinator
        self.session = session
    }

    func updateCellsInfo(completion: @escaping () -> Void) {

        session.requestManager.requestUpdateAllCountries()
        session.requestManager.requestAllCountriesFromDB() { [weak self] countries in

            guard
                let countries = countries,
                let strongSelf = self
            else {
                print("No countries retrieved")
                completion()
                return
            }

            strongSelf.countriesData = countries
            completion()
        }
    }

    func selectedCountry(_ indexPath: IndexPath) {

        coordinator.showCountryDetails(countriesData[indexPath.row])
    }
}
