//
//  HomeViewController.swift
//  Forecasty
//
//  Created by Gonçalo Neves on 15/06/2021.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: Properties

    let viewModel: HomeViewModel

    // MARK: - UI

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.alwaysBounceVertical = true
        return tableView
    }()

    init(viewModel: HomeViewModel) {

        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }

    private func setupUI() {
        tableView.alwaysBounceVertical = true
    }
}

