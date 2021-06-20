//
//  Session.swift
//  Forecasty
//
//  Created by Gonçalo Neves on 18/06/2021.
//

import Foundation

class Session {

    // MARK: Properties

    let constants: Constants
    let requestManager: RequestManager

    // MARK: Lifecycle

    init(
        constants: Constants,
        requestManager: RequestManager
    ) {
        self.constants = constants
        self.requestManager = requestManager
    }
}
