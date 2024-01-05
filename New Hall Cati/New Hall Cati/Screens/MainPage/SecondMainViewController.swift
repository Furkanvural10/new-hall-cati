//
//  SecondMainViewController.swift
//  New Hall Cati
//
//  Created by furkan vural on 5.01.2024.
//

import UIKit

class SecondMainViewController: UIViewController {
    
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        configureViewCollectionView()
        super.viewDidLoad()

    }
    
    func configureViewCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBlue
        collectionView.register(DishCell.self, forCellWithReuseIdentifier: DishCell.reusedID)
    }

}
