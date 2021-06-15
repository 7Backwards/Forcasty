//
//  CoordinatorProtocol.swift
//  Forecasty
//
//  Created by Gonçalo Neves on 15/06/2021.
//

import Foundation
import UIKit

protocol CoordinatorProtocol {

    var presentedCoordinator: CoordinatorProtocol? { get set }

    var navigationController: UINavigationController { get set }

    // Starts the coordinator by presenting the viewController
    func start()

}
