//
//  Country+CoreDataProperties.swift
//  Forecasty
//
//  Created by Gonçalo Neves on 17/06/2021.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var name: String?
    @NSManaged public var capital: String?
    @NSManaged public var region: String?
    @NSManaged public var area: Float
    @NSManaged public var population: Int64
    @NSManaged public var subregion: String?

}

extension Country : Identifiable {

}
