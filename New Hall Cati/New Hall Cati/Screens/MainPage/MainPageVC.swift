//
//  MainPageVC.swift
//  New Hall Cati
//
//  Created by furkan vural on 29.12.2023.
//

import UIKit

final class MainPageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setTitle() {
        
        let today = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        formatter.locale = Locale(identifier: "tr_TR")
        let dateString = formatter.string(from: today)
        
        self.title = dateString
    }
}
