//
//  HomeViewModel.swift
//  Forecasty
//
//  Created by Gonçalo Neves on 16/06/2021.
//

import Foundation

class HomeViewModel {

    let networkManager: NetworkManager
    let coordinator: CoordinatorProtocol

    init(
        networkManager: NetworkManager,
        coordinator: CoordinatorProtocol
    ) {
        self.networkManager = networkManager
        self.coordinator = coordinator
    }

    func updateCellsInfo() {

        // TODO
    }
}
