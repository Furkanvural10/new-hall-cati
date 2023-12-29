//
//  MainPageVC.swift
//  New Hall Cati
//
//  Created by furkan vural on 29.12.2023.
//

import UIKit

final class MainPageVC: UIViewController {
    
    private let viewModel = MainPageViewModel()
//    private var collectionView: UICollectionView!
    private var workingTitleLabel: UILabel!
    private var workingHourLabel: UILabel!
    private var workingDetailView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        configureUI()
        configureTitle()
        configureCollectionView()
        
        configureWorkingLabel()
        configureHourLabel()
        configureWorkingDetailView()
        
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTitle() {
        viewModel.setTitle()
    }
    
    private func configureCollectionView() {
//        collectionView = UICollectionView(frame: .zero)
//        view.addSubview(collectionView)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            collectionView.col
//        ])
    }
    
    
    
    private func configureWorkingLabel() {
        workingTitleLabel = UILabel()
        workingTitleLabel.font = UIFont.systemFont(ofSize: 13)
        workingTitleLabel.text = "Açılış-Kapanış"
        
        view.addSubview(workingTitleLabel)
        workingTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            workingTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            workingTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
//            workingTitleLabel.heightAnchor.constraint(equalToConstant: 40)
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
//            workingHourLabel.heightAnchor.constraint(equalToConstant: 4)
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
