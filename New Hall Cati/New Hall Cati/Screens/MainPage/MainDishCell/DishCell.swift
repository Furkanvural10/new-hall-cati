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
        
        dishNameLabel.adjustsFontSizeToFitWidth = true
        dishNameLabel.textAlignment = .center
        dishNameLabel.minimumScaleFactor = 0.9
        dishNameLabel.lineBreakMode = .byTruncatingTail
        
        dishPriceLabel.adjustsFontSizeToFitWidth = true
        dishPriceLabel.textAlignment = .center
        dishPriceLabel.minimumScaleFactor = 0.9
        dishPriceLabel.lineBreakMode = .byTruncatingTail
        
        NSLayoutConstraint.activate([
            dishImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            dishImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            dishImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            dishImageView.heightAnchor.constraint(equalTo: dishImageView.widthAnchor),
            
            
            dishNameLabel.topAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: 8),
            dishNameLabel.centerXAnchor.constraint(equalTo: dishImageView.centerXAnchor),
            dishNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            dishNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            dishNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            
            dishPriceLabel.topAnchor.constraint(equalTo: dishNameLabel.bottomAnchor, constant: 5),
            dishPriceLabel.centerXAnchor.constraint(equalTo: dishImageView.centerXAnchor),
            dishPriceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            dishPriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            dishPriceLabel.heightAnchor.constraint(equalToConstant: 20)
            
        ])
    }
}
