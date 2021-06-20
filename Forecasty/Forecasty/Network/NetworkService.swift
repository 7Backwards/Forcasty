//
//  NetworkManager.swift
//  Forecasty
//
//  Created by Gonçalo Neves on 16/06/2021.
//

import Foundation

class NetworkService {

    struct RequestParameters {
        let url: String
        let httpMethod: String
        let headers: [String: String]
    }

    // MARK: Public methods

    func request( requestParameters: RequestParameters, completion: @escaping (Result<Data, Error>) -> Void) {

        let request = NSMutableURLRequest(url: NSURL(string: requestParameters.url)! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = requestParameters.httpMethod
        request.allHTTPHeaderFields = requestParameters.headers

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
