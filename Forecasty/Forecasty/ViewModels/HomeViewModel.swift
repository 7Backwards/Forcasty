//
//  HomeViewModel.swift
//  Forecasty
//
//  Created by Gonçalo Neves on 16/06/2021.
//

import CoreData
import Foundation
import UIKit
import OSLog

class HomeViewModel {

    // MARK: Properties

    let coordinator: MainCoordinator
    let session: Session
    var countriesData = [Country]()
    let cellHeight: CGFloat = 200
    let horizontalConstraintConstant: CGFloat = 15
    let collectionViewLayoutMinimumInteritemSpacing: CGFloat = 5

    // MARK: Lifecycle

    init(coordinator: MainCoordinator, session: Session) {
        self.coordinator = coordinator
        self.session = session
    }

    // MARK: Public Methods

    func updateCellsInfo(completion: @escaping () -> Void) {

        session.requestManager.requestUpdateAllCountries() { [weak self] in

            self?.session.requestManager.requestAllCountriesFromDB() { [weak self] countries in

                guard
                    let countries = countries,
                    let strongSelf = self
                else {
                    os_log("No countries retrieved", type: .info)
                    completion()
                    return
                }

                strongSelf.countriesData = countries
                completion()
            }
        }
    }

    func fetchCellsInfo(completion: @escaping (Bool) -> Void) {

        self.session.requestManager.requestAllCountriesFromDB() { [weak self] countries in

            guard let strongSelf = self else {
                os_log("Something went wrong! Somehow we've reached here without 'self' value.", type: .error)
                completion(false)
                return
            }

            guard let countries = countries else {
                os_log("Error unwrapping countries retrieved from database", type: .error)
                completion(false)
                return
            }

            if countries.count < 1 {
               completion(false)
            } else {
                strongSelf.countriesData = countries
                completion(true)
            }
        }
    }

    func selectedCountry(_ indexPath: IndexPath) {

        coordinator.showCountryDetails(countriesData[indexPath.row])
    }
}
