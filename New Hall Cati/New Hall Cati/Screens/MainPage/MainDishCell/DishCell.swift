import UIKit
import SDWebImage

class DishCell: UICollectionViewCell {
    
    static let reusedID = "MainDishCell"
    
    let backView = UIView()
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
    
    func set(product: Product) {
        let url = URL(string: product.image)
        dishNameLabel.text = product.name
        dishPriceLabel.text = product.price
        dishImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "menu-placeholder"))
    }
    
    private func configure() {
        
        addSubview(dishImageView)
        addSubview(dishNameLabel)
        addSubview(dishPriceLabel)
        addSubview(backView)
        
        dishImageView.translatesAutoresizingMaskIntoConstraints = false
        dishNameLabel.translatesAutoresizingMaskIntoConstraints = false
        dishPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        backView.translatesAutoresizingMaskIntoConstraints = false
        
        backView.backgroundColor = .white.withAlphaComponent(0.11)
        backView.layer.cornerRadius = 8
        
        dishNameLabel.adjustsFontSizeToFitWidth = true
        dishNameLabel.textColor = .white
        dishNameLabel.textAlignment = .center
        dishNameLabel.minimumScaleFactor = 0.9
        dishNameLabel.lineBreakMode = .byTruncatingTail
        dishNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        dishPriceLabel.adjustsFontSizeToFitWidth = true
        dishPriceLabel.textColor = .white
        dishPriceLabel.textAlignment = .center
        dishPriceLabel.lineBreakMode = .byTruncatingTail
        dishPriceLabel.font = UIFont.systemFont(ofSize: 15)
                
        NSLayoutConstraint.activate([
            
            backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            backView.heightAnchor.constraint(equalToConstant: 160),
            backView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.95),
            
            dishImageView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10),
            dishImageView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 5),
            dishImageView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -5),
            dishImageView.heightAnchor.constraint(equalToConstant: 90),
            
            dishNameLabel.topAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: 8),
            dishNameLabel.centerXAnchor.constraint(equalTo: dishImageView.centerXAnchor),
            dishNameLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 2),
            dishNameLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -2),
            dishNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            dishPriceLabel.topAnchor.constraint(equalTo: dishNameLabel.bottomAnchor, constant: 5),
            dishPriceLabel.centerXAnchor.constraint(equalTo: dishImageView.centerXAnchor),
            dishPriceLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 5),
            dishPriceLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -5),
            dishPriceLabel.heightAnchor.constraint(equalToConstant: 20)
            
        ])
    }
}
