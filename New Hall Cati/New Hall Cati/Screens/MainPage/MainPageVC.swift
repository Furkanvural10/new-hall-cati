//
//  MainPageVC.swift
//  New Hall Cati
//
//  Created by furkan vural on 29.12.2023.
//

import UIKit

final class MainPageVC: UIViewController {
    
    private let viewModel = MainPageViewModel()
    private enum ProductType: String, CaseIterable {
        case dish = "Ana Yemek"
        case drink = "İçecekler"
        case dessert = "Tatlılar"
    }
    private var productTitleList: [ProductType] = [.dish, .drink, .dessert]
    
    private var dateTitleLabel: UILabel!
    private var workingTitleLabel: UILabel!
    private var workingHourLabel: UILabel!
    private var workingDetailView: UIView!
    private var header: TableViewHeader!
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        tableView.register(CellHeader.self, forHeaderFooterViewReuseIdentifier: CellHeader.identifier)
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Delegates
        viewModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        // MARK: - SetupUI
        configureUI()
        configureTitle()
        configureDateTitle()
        configureWorkingLabel()
        configureHourLabel()
        configureWorkingDetailView()
        configureTableView()
//        configureTableViewHeader()
        
    }
    
    private func configureUI() { view.backgroundColor = .white }
    
    private func configureTitle() {
        let titleLabel = UILabel()
        titleLabel.text = "New Hall Çatı"
        titleLabel.font = UIFont.pacificoRegular(size: 20)
        titleLabel.textColor = .label
        
        self.navigationItem.titleView = titleLabel
        
    }
    
    private func configureDateTitle() {
        dateTitleLabel = UILabel()
        view.addSubview(dateTitleLabel)
        dateTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            dateTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5)
        ])
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
    
    private func configureTableViewHeader() {
        header = TableViewHeader(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200))
        tableView.tableHeaderView = header
        tableView.tableHeaderView?.backgroundColor = .yellow
        if #available(iOS 15.0, *) { tableView.sectionHeaderTopPadding = 0.0 }
    }
    
    private func configureWorkingLabel() {
        workingTitleLabel = UILabel()
        workingTitleLabel.font = UIFont.boldSystemFont(ofSize: 13)
        workingTitleLabel.text = "Açılış-Kapanış"
        
        view.addSubview(workingTitleLabel)
        workingTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            workingTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
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
            workingDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13),
            workingDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            workingDetailView.heightAnchor.constraint(equalTo: workingHourLabel.heightAnchor, multiplier: 2.55),
            workingDetailView.widthAnchor.constraint(equalTo: workingHourLabel.widthAnchor, multiplier: 1.27)
            
        ])
    }
    
}

extension MainPageVC: MainPageViewModelProtocol {
    
    func setTitle(dateString: String) {
        
        dateTitleLabel.text = dateString
        dateTitleLabel.font = .systemFont(ofSize: 25)
    }
}

extension MainPageVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ProductType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CellHeader") as? CellHeader else { fatalError("main header fail") }
        let headerTitle = productTitleList[section].rawValue
        header.setTitle(with: headerTitle)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else {
            fatalError("Could not dequeue cell with identifier: \(MainTableViewCell.identifier)")
        }
        cell.set()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
}
