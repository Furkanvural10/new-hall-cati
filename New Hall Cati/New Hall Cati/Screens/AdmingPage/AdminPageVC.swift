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
}

final class AdminPageVC: UIViewController, AdminPageProtocol {
    
    
    lazy var allFoodList = [String]()
    lazy var allDessertList = [String]()
    lazy var allDrinkList = [String]()
    var viewModel = AdminPageViewModel()

//    MARK: - UI Elements
    private var segmentedController: CustomSegmentedController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSegmentedController()
        view.backgroundColor = .systemBackground
        
    }
    
    private func configureSegmentedController() {
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
}
