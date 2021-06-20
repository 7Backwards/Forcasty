//
//  Constants.swift
//  Forecasty
//
//  Created by Gonçalo Neves on 16/06/2021.
//

import Foundation

class Constants {

    // MARK: Properties

    lazy var apiKey: String = { () -> String in

        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
          fatalError("Couldn't find file 'Info.plist'.")
        }

        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
          fatalError("Couldn't find key 'API_KEY' in 'Info.plist'.")
        }
        return value
    }()

    let apiHostURL = "restcountries-v1.p.rapidapi.com"

    let apiBaseCountriesURL = "https://restcountries-v1.p.rapidapi.com/"
    lazy var apiGetAllCountriesURL = apiBaseCountriesURL + "all"

    func apiGetCountryByNameURL(countryName: String) -> String {

        "\(apiBaseCountriesURL) name/ \(countryName)"
    }

    let navigationItemTitle = "Forecasty"
}
