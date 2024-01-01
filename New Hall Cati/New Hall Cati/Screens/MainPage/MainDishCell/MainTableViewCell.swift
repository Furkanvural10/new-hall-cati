//
//  MainTableViewCell.swift
//  New Hall Cati
//
//  Created by furkan vural on 31.12.2023.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    static let identifier = "CustomCell"
    
    let image = CustomImageView(frame: .zero)
    
    private let nameLabel : UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .label
        return nameLabel
    }()
    
    private let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.textColor = .label
        return priceLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set() {
        image.image = UIImage(named: "hamburger")
        nameLabel.text = "Pilav Üstü Döner"
        priceLabel.text = "130 ₺"
        
        nameLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func configure() {
        self.contentView.addSubview(image)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(priceLabel)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
//            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            image.heightAnchor.constraint(equalToConstant: 52),
            image.widthAnchor.constraint(equalToConstant: 52),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 15),
//            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7),
            priceLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 15),
//            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 2),
            priceLabel.heightAnchor.constraint(equalToConstant: 22),
        ])
    }

}
