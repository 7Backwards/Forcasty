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
class Country: NSManagedObject, Decodable {

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case capital = "capital"
        case region = "region"
        case subregion = "subregion"
        case population = "population"
        case area = "area"
    }

    required convenience init(from decoder: Decoder) throws {

        guard
            let context = decoder.userInfo[.context] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Country", in: context)
        else {
          fatalError("fatal error")
        }

        self.init(entity: entity, insertInto: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.capital = try container.decodeIfPresent(String.self, forKey: .capital)
        self.region = try container.decodeIfPresent(String.self, forKey: .region)
        self.area = try container.decodeIfPresent(Float.self, forKey: .area) ?? 0
        self.subregion = try container.decodeIfPresent(String.self, forKey: .subregion)
        self.population = try container.decodeIfPresent(Int64.self, forKey: .population) ?? 0
    }
}
