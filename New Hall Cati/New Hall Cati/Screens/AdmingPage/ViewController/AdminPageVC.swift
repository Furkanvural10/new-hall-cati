import UIKit


protocol AdminPageProtocol: AnyObject {
    func fetchDish(product: [Product])
    
    
}

final class AdminPageVC: UIViewController {
    
    private var allMainDishButton: UIButton!
    private var allDrinkButton: UIButton!
    private var allSnackButton: UIButton!
    private var allDessertButton: UIButton!
    private var addNewProductButton: UIButton!
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        configureAddNewProductButton()
        createUI()
    }
    
    func configureAddNewProductButton() {
        addNewProductButton = UIButton()
        addNewProductButton.setTitle("+ Add New Product", for: .normal)
        addNewProductButton.layer.cornerRadius = 10
        addNewProductButton.backgroundColor = .systemGreen
        
        view.addSubview(addNewProductButton)
        addNewProductButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addNewProductButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addNewProductButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addNewProductButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addNewProductButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06),
            addNewProductButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80)
        ])
        
        addNewProductButton.addTarget(self, action: #selector(clickedAddNewProductButton), for: .touchUpInside)
        
    }
    
    private func createUI() {
        
        // MARK: - Main Dish Button
        allMainDishButton = UIButton()
        allMainDishButton.setTitle("Ana Yemek", for: .normal)
        allMainDishButton.backgroundColor = .systemOrange
        allMainDishButton.layer.cornerRadius = 15
        
        view.addSubview(allMainDishButton)
        allMainDishButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            allMainDishButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            allMainDishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            allMainDishButton.heightAnchor.constraint(equalToConstant: 120),
            allMainDishButton.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        allMainDishButton.addTarget(self, action: #selector(sendUpdateVC(_:)), for: .touchUpInside)
        
        allSnackButton = UIButton()
        allSnackButton.setTitle("Mezeler", for: .normal)
        allSnackButton.backgroundColor = .white.withAlphaComponent(0.7)
        allSnackButton.layer.cornerRadius = 15
        
        view.addSubview(allSnackButton)
        allSnackButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            allSnackButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            allSnackButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            allSnackButton.heightAnchor.constraint(equalToConstant: 120),
            allSnackButton.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        allSnackButton.addTarget(self, action: #selector(sendUpdateVC(_:)), for: .touchUpInside)
        
        allDessertButton = UIButton()
        allDessertButton.setTitle("Tatlılar", for: .normal)
        allDessertButton.backgroundColor = .systemPurple
        allDessertButton.layer.cornerRadius = 15
        
        view.addSubview(allDessertButton)
        allDessertButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            allDessertButton.topAnchor.constraint(equalTo: allSnackButton.bottomAnchor, constant: 100),
            allDessertButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            allDessertButton.heightAnchor.constraint(equalToConstant: 120),
            allDessertButton.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        allDessertButton.addTarget(self, action: #selector(sendUpdateVC(_:)), for: .touchUpInside)
        
        allDrinkButton = UIButton()
        allDrinkButton.setTitle("İçecekler", for: .normal)
        allDrinkButton.backgroundColor = .systemBlue
        allDrinkButton.layer.cornerRadius = 15
        
        view.addSubview(allDrinkButton)
        allDrinkButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            allDrinkButton.topAnchor.constraint(equalTo: allMainDishButton.bottomAnchor, constant: 100),
            allDrinkButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            allDrinkButton.heightAnchor.constraint(equalToConstant: 120),
            allDrinkButton.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        allDrinkButton.addTarget(self, action: #selector(sendUpdateVC(_:)), for: .touchUpInside)
    }
    
    @objc private func clickedAddNewProductButton() {
        let newProductVC = NewProductViewController()
        self.navigationController?.pushViewController(newProductVC, animated: true)
    }
    
    @objc private func sendUpdateVC(_ sender: UIButton) {
        
        let updateProductVC = UpdateProductVC()
        
        switch sender {
        case allMainDishButton:
            print("All M")
            updateProductVC.selectedProduct = "AllMainDish"
        case allSnackButton:
            updateProductVC.selectedProduct = "AllSnack"
        case allDrinkButton:
            updateProductVC.selectedProduct = "AllHotDrink"
        case allDessertButton:
            updateProductVC.selectedProduct = "AllDessert"
            
        default:
            break
        }
        
        self.navigationController?.pushViewController(updateProductVC, animated: true)
    }
}

