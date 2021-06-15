//
//  UIView+Extensions.swift
//  Forecasty
//
//  Created by Gonçalo Neves on 15/06/2021.
//

import Foundation
import UIKit

extension UIView {

    @discardableResult func addSubviews(_ subViews: UIView...) -> Self {

        subViews.forEach(addSubview)
        return self
    }
}
