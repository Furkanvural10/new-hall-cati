//
//  FavoriteProductVC.swift
//  New Hall Cati
//
//  Created by furkan vural on 29.08.2024.
//

import UIKit

protocol FavoriteProductProtocol {
    func createUI()
    
}

final class FavoriteProductVC: UIViewController {
    
    private var favoriteProductTableView: UITableView!
    
    var mockdata = ["1","2","3","4"]

    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    
    func createUI() {
        configureViewController()
        configureTableView()
        
        
    }
    
    private func configureViewController() {
        view.backgroundColor = .black
        navigationController?.title = "Deneme"
    }
    
    private func configureTableView() {
        favoriteProductTableView = UITableView()
        favoriteProductTableView.backgroundColor = .black
        favoriteProductTableView.delegate = self
        favoriteProductTableView.dataSource = self
        
        view.addSubview(favoriteProductTableView)
        favoriteProductTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favoriteProductTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoriteProductTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoriteProductTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoriteProductTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension FavoriteProductVC: FavoriteProductProtocol { }

extension FavoriteProductVC: UITableViewDelegate, UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = mockdata[indexPath.row]
        cell.detailTextLabel?.text = "Deneme"
        return cell
    }
}
