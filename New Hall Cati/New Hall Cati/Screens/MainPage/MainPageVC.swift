//
//  MainPageVC.swift
//  New Hall Cati
//
//  Created by furkan vural on 29.12.2023.
//

import UIKit

final class MainPageVC: UIViewController {
    
    private let viewModel = MainPageViewModel()

    private var workingTitleLabel: UILabel!
    private var workingHourLabel: UILabel!
    private var workingDetailView: UIView!
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        configureUI()
        configureTitle()
        
        configureWorkingLabel()
        configureHourLabel()
        configureWorkingDetailView()
        configureTableView()
        
    }
    
    private func configureUI() {
        view.backgroundColor = .white
//        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTitle() {
        viewModel.setTitle()
    }
    
    
    private func configureTableView() {
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.workingDetailView.bottomAnchor, constant: 20),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
    }
    
    private func configureWorkingLabel() {
        workingTitleLabel = UILabel()
        workingTitleLabel.font = UIFont.boldSystemFont(ofSize: 13)
        workingTitleLabel.text = "Açılış-Kapanış"
        
        view.addSubview(workingTitleLabel)
        workingTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            workingTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            workingTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
        
    }
    
    private func configureHourLabel() {
        workingHourLabel = UILabel()
        workingHourLabel.font = UIFont.systemFont(ofSize: 13)
        workingHourLabel.text = "09:00 - 15:00"
        
        view.addSubview(workingHourLabel)
        workingHourLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            workingHourLabel.topAnchor.constraint(equalTo: workingTitleLabel.bottomAnchor, constant: 4),
            workingHourLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }
    
    private func configureWorkingDetailView() {
        
        workingDetailView = UIView()
        workingDetailView.backgroundColor = .systemGray5
        view.addSubview(workingDetailView)
        workingDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        workingDetailView.addSubview(workingHourLabel)
        workingDetailView.addSubview(workingTitleLabel)
        
        workingDetailView.layer.cornerRadius = 8
        
        NSLayoutConstraint.activate([
            workingDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -3),
            workingDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19),
            workingDetailView.heightAnchor.constraint(equalTo: workingHourLabel.heightAnchor, multiplier: 2.55),
            workingDetailView.widthAnchor.constraint(equalTo: workingHourLabel.widthAnchor, multiplier: 1.27)
            
        ])
    }
    
}

extension MainPageVC: MainPageViewModelProtocol {
    
    func setTitle(dateString: String) {
        title = dateString
    }
}

extension MainPageVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else {     fatalError("Could not dequeue cell with identifier: \(MainTableViewCell.identifier)")
 }
        cell.set()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
