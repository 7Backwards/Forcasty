//
//  Session.swift
//  Forecasty
//
//  Created by Gonçalo Neves on 18/06/2021.
//

import Foundation

class Session {

    let constants: Constants
    let requestManager: RequestManager

    init(
        constants: Constants,
        requestManager: RequestManager
    ) {
        self.constants = constants
        self.requestManager = requestManager
    }
}
