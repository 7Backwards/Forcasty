//
//  CoreDataManager.swift
//  Forecasty
//
//  Created by Gonçalo Neves on 18/06/2021.
//

import CoreData
import Foundation
import UIKit

class CoreDataManager {

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Forecasty")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

// Countries

extension CoreDataManager {

    func saveCountries(countryData: Data) {

        let context = persistentContainer.viewContext

        let decoder = JSONDecoder()

        do {
            try _ = decoder.decode(Country.self, from: countryData)
        } catch {
            print("error decoding country")
        }

        do {
            try context.save()
        } catch {
            print("error saving context")
        }
    }

    func fetchSavedCountries(completion: @escaping ([Country]?) -> Void) {

        let request: NSFetchRequest<Country> = Country.fetchRequest()
        request.returnsObjectsAsFaults = false
        do {
            let countries = try persistentContainer.viewContext.fetch(request)
            completion(countries)

        } catch {
            print("Fetch failed")
            completion(nil)
        }
    }
}
