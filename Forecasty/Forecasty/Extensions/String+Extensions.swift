//
//  String+Extensions.swift
//  Forecasty
//
//  Created by Gonçalo Neves on 16/06/2021.
//

import Foundation

extension String {

    func localized() -> String {

        NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self
        )
    }
}
