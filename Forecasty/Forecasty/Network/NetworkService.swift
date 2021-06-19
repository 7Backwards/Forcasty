//
//  NetworkManager.swift
//  Forecasty
//
//  Created by Gonçalo Neves on 16/06/2021.
//

import Foundation

class NetworkService {

    // MARK: Properties

    let constants: Constants

    lazy var headers = [
        "x-rapidapi-key": "\(constants.apiKey)",
        "x-rapidapi-host": "\(constants.apiHostURL)"
    ]

    // MARK: Lifecycle

    init(constants: Constants) {
        self.constants = constants
    }

    // MARK: Public methods

    func fetchAllCountriesInformation(completion: @escaping (Result<Data, Error>) -> Void) {

        let request = NSMutableURLRequest(url: NSURL(string: constants.apiGetAllCountriesURL)! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, _, error) -> Void in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            }
        })

        dataTask.resume()
    }
    
}
