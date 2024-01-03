//
//  CustomSegmentedController.swift
//  New Hall Cati
//
//  Created by furkan vural on 3.01.2024.
//

import UIKit

class CustomSegmentedController: UISegmentedControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setItems(_ items: [Any], startingIndex: Int) {
        items.enumerated().forEach { index, item in
            insertSegment(withTitle: "\(item)", at: index, animated: true)
        }
        selectedSegmentIndex = startingIndex
        
        
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}
