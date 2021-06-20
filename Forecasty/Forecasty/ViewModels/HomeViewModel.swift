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
                    print("No countries retrieved")
                    completion()
                    return
                }

                strongSelf.countriesData = countries
                completion()
            }
        }
    }

    func fetchCellsInfo(completion: @escaping () -> Void) {

        self.session.requestManager.requestAllCountriesFromDB() { [weak self] countries in

            guard
                let countries = countries,
                let strongSelf = self
            else {
                completion()
                print("error")
                return
            }

            if countries.count < 1 {
                self?.updateCellsInfo() {
                    completion()
                }
            } else {
                strongSelf.countriesData = countries
                completion()
            }
        }
    }

    func selectedCountry(_ indexPath: IndexPath) {

        coordinator.showCountryDetails(countriesData[indexPath.row])
    }
}
