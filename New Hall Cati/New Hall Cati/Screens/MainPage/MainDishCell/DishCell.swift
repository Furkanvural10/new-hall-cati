

import UIKit

class DishCell: UICollectionViewCell {
    
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
        
        dishImageView.translatesAutoresizingMaskIntoConstraints = false
        dishNameLabel.translatesAutoresizingMaskIntoConstraints = false
        dishPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dishImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            dishImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            dishImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            dishImageView.heightAnchor.constraint(equalTo: dishImageView.widthAnchor),
            
            dishNameLabel.topAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: 8),
            dishNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            dishNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            dishNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            dishPriceLabel.topAnchor.constraint(equalTo: dishNameLabel.bottomAnchor, constant: 12),
            dishPriceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            dishPriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            dishPriceLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
