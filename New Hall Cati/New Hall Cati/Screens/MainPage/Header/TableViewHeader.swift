//
//  TableViewHeader.swift
//  New Hall Cati
//
//  Created by furkan vural on 31.12.2023.
//

import UIKit

class TableViewHeader: UIView {
    

    private let header: UIView = {
        let header = UIView()
        return header
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(header)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            header.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            header.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            header.heightAnchor.constraint(equalToConstant: 200)
        ])
        
    }
    
}
