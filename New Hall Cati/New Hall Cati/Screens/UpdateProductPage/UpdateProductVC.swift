//
//  UpdateProductVC.swift
//  New Hall Cati
//
//  Created by furkan vural on 16.05.2024.
//

import UIKit

final class UpdateProductVC: UIViewController {
    
    
    
    
    var selectedProduct: String?
    private var tableView: UITableView!
    var showingList: [Product] = []
    private var viewModel = AdminPageViewModel()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        viewModel.delegate = self
        configureRightBarButtonItem()
        getProduct()
        configureTableView()
        
    }
    
    private func configureRightBarButtonItem() {
        let barButton = UIBarButtonItem(title: "Kaydet", style: .plain, target: self, action: #selector(clickedRightBarButton))
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    private func configureTableView() {
        tableView = UITableView()
        tableView.register(CellView.self, forCellReuseIdentifier: CellView.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func getProduct() {
        guard let selectedProduct else { return }
        viewModel.getAllMainDish(product: selectedProduct)
    }
    
    @objc private func clickedRightBarButton() {
        print("Kaydet")
    }
    
    
    
    
}



extension UpdateProductVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellView.identifier, for: indexPath) as? CellView else {
            fatalError("Could not dequeue cell with identifier: \(CellView.identifier)")
        }
        
        cell.set(with: showingList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}

extension UpdateProductVC: AdminPageProtocol {
    func fetchDish(product: [Product]) {
        showingList = product
        tableView.reloadData()
    }
}



