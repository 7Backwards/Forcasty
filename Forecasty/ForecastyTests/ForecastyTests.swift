//
//  ForecastyTests.swift
//  ForecastyTests
//
//  Created by Gonçalo Neves on 15/06/2021.
//

import XCTest
@testable import Forecasty

class ForecastyTests: XCTestCase {

    lazy var countryJson: String = {

        guard let pathString = Bundle(for: type(of: self)).path(forResource: "Country", ofType: "json") else {
            fatalError("Json file not found")
        }

        guard let json = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert json to String")
        }

        return json
    }()

    lazy var countryJsonData: Data = {

        return countryJson.data(using: .utf8)!
    }()

    lazy var countriesJson: String = {

        guard let pathString = Bundle(for: type(of: self)).path(forResource: "Countries", ofType: "json") else {
            fatalError("Json file not found")
        }

        guard let json = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert json to String")
        }

        return json
    }()

    lazy var countriesJsonData: Data = {

        return countriesJson.data(using: .utf8)!
    }()

    let coreDataManager = CoreDataManager()

    func testJSONCountryDecoder() throws {

        let decoder = JSONDecoder()
        decoder.userInfo[.context] = coreDataManager.persistentContainer.viewContext
        let country = try decoder.decode(Country.self, from: countryJsonData)

        XCTAssertEqual("Afghanistan", country.name)
        XCTAssertEqual("Kabul", country.capital)
        XCTAssertEqual("Asia", country.region)
        XCTAssertEqual(652230.0, country.area)
        XCTAssertEqual(26023100, country.population)
        XCTAssertEqual("Southern Asia", country.subregion)
    }

    func testJSONCountriesDecoder() throws {

        let decoder = JSONDecoder()
        decoder.userInfo[.context] = coreDataManager.persistentContainer.viewContext
        let countries = try decoder.decode([Country].self, from: countriesJsonData)

        XCTAssertEqual(250, countries.count)

        XCTAssertEqual("Afghanistan", countries.first!.name)
        XCTAssertEqual("Kabul", countries.first!.capital)
        XCTAssertEqual("Asia", countries.first!.region)
        XCTAssertEqual(652230.0, countries.first!.area)
        XCTAssertEqual(26023100, countries.first!.population)
        XCTAssertEqual("Southern Asia", countries.first!.subregion)

        XCTAssertEqual("Zimbabwe", countries.last!.name)
        XCTAssertEqual("Harare", countries.last!.capital)
        XCTAssertEqual("Africa", countries.last!.region)
        XCTAssertEqual(390757.0, countries.last!.area)
        XCTAssertEqual(13061239, countries.last!.population)
        XCTAssertEqual("Eastern Africa", countries.last!.subregion)
    }
}
