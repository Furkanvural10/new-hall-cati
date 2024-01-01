//
//  CellHeader.swift
//  New Hall Cati
//
//  Created by furkan vural on 31.12.2023.
//

import UIKit

class CellHeader: UITableViewHeaderFooterView {
    
    static let identifier = "CellHeader"
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(with title: String) {
        self.titleLabel.text = title
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        configureHeaderTitle()
    }
    
    private func configureHeaderTitle() {
        
        self.contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
        ])
        
    }
    
}
