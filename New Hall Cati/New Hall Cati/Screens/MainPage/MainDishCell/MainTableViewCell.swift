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
    
//    private let imageV : UIImageView = {
//        let imageV = UIImageView()
//        imageV.image = UIImage(systemName: "folder")
//        return imageV
//    }()
    
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
        image.image = UIImage(systemName: "folder")
        nameLabel.text = "Pilav Üstü Döner"
        priceLabel.text = "130 ₺"
    }
    
    private func configure() {
        self.contentView.addSubview(image)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(priceLabel)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
//            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            image.heightAnchor.constraint(equalToConstant: 40),
            image.widthAnchor.constraint(equalToConstant: 40),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 30),
//            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 30),
//            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 2),
            priceLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }

}
