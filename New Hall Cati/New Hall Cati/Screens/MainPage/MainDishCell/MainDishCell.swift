

import UIKit

class MainDishCell: UICollectionViewCell {
    
    static let reusedID = "MainDishCell"
    
    let dishImageView = CustomImageView(frame: .zero)
    let dishNameLabel = UILabel()
    let dishPriceLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(dish: Dish) {
        dishImageView.image = dish.image
        dishNameLabel.text = dish.name
        dishPriceLabel.text = dish.price
    }
    
    private func configure() {
        addSubview(dishImageView)
        addSubview(dishNameLabel)
        addSubview(dishPriceLabel)
        
        NSLayoutConstraint.activate([
            dishImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            dishImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            dishImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            dishImageView.heightAnchor.constraint(equalTo: dishImageView.heightAnchor),
            
            dishNameLabel.topAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: 5),
            dishNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            dishNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            dishNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            dishPriceLabel.topAnchor.constraint(equalTo: dishNameLabel.bottomAnchor, constant: 2),
            dishPriceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            dishPriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 2),
            dishPriceLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
