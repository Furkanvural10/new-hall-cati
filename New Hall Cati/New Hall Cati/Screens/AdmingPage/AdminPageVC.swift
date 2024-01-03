//
//  AdminPageVC.swift
//  New Hall Cati
//
//  Created by furkan vural on 3.01.2024.
//

import UIKit

protocol AdminPageProtocol {
    
    var allFoodList: [String] { get }
    var allDessertList: [String] { get }
    var allDrinkList: [String] { get }
    var viewModel: AdminPageViewModel { get }
    
    func configureSegmentedController()
    func configureTableView()
}

final class AdminPageVC: UIViewController, AdminPageProtocol {
    
    
    lazy var allFoodList = [String]()
    lazy var allDessertList = [String]()
    lazy var allDrinkList = [String]()
    var viewModel = AdminPageViewModel()

//    MARK: - UI Elements
    private var segmentedController: CustomSegmentedController!
    private var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureSegmentedController()
        configureTableView()
        
        
    }
    
     func configureSegmentedController() {
        segmentedController = CustomSegmentedController(frame: .zero)
        let items = ["Ana Yemek", "Tatlılar", "İçecekler"]
        segmentedController.setItems(items, startingIndex: 0)
        
        view.addSubview(segmentedController)
        
        NSLayoutConstraint.activate([
            segmentedController.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            segmentedController.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            segmentedController.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)
        ])
    }
    
    func configureTableView() {
        tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentedController.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
}

extension AdminPageVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Deneme"
        return cell
    }
}
