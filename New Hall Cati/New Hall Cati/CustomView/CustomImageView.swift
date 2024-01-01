//
//  CustomImageView.swift
//  New Hall Cati
//
//  Created by furkan vural on 29.12.2023.
//

import UIKit

class CustomImageView: UIImageView {
    
    let placeholderImage = UIImage(named: "hamburger")

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
