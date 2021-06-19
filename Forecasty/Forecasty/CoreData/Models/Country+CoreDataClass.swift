//
//  Country+CoreDataClass.swift
//  Forecasty
//
//  Created by Gonçalo Neves on 17/06/2021.
//
//

import Foundation
import CoreData

@objc(Country)
public class Country: NSManagedObject, Codable {

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case capital = "capital"
        case region = "region"
    }

    required convenience public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.init()

        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.capital = try container.decodeIfPresent(String.self, forKey: .capital)
        self.region = try container.decodeIfPresent(String.self, forKey: .region)
    }

    // MARK: - Encodable

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(capital, forKey: .capital)
        try container.encode(region, forKey: .region)
    }
    
}
