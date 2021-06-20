//
//  RequestManager.swift
//  Forecasty
//
//  Created by Gonçalo Neves on 17/06/2021.
//

import Foundation

class RequestManager {

    // MARK: Properties

    let networkService: NetworkService
    let constants: Constants
    let coreDataManager: CoreDataManager

    lazy var headers = [
        "x-rapidapi-key": "\(constants.apiKey)",
        "x-rapidapi-host": "\(constants.apiHostURL)"
    ]

    // MARK: Lifecycle

    init(
        networkService: NetworkService,
        constants: Constants,
        coreDataManager: CoreDataManager
    ) {
        self.networkService = networkService
        self.constants = constants
        self.coreDataManager = coreDataManager
    }

    // MARK: Request methods

    func requestUpdateAllCountries() {
        networkService.request(
            requestParameters: NetworkService.RequestParameters(
                url: constants.apiGetAllCountriesURL,
                httpMethod: "GET",
                headers: headers
            )
        ) { [weak self] result in

            switch result {

            case .success(let data):
                do {
                    let decoder = JSONDecoder()

                    decoder.userInfo[.context] = self?.coreDataManager.persistentContainer.viewContext

                    let countries = try decoder.decode([Country].self, from: data)

                    for country in countries {
                        print(country)
                    }
                    DispatchQueue.main.async { [weak self] in

                        guard let self = self else {

                            print("Something went wrong! Somehow we've reached here without 'self' value.")
                            return
                        }
                        self.coreDataManager.saveContext()
                    }
                } catch(let error) {
                    print(error)
                }
               
            case .failure(let error):
                print(error)
            }
        }
    }

    func requestAllCountriesFromDB(completion: @escaping ([Country]?) -> Void) {

        coreDataManager.fetchSavedCountries { countries in
            completion(countries)
        }
    }
}
