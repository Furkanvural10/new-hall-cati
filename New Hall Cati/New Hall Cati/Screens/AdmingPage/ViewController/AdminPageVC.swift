import UIKit
import PhotosUI


protocol AdminPageProtocol: AnyObject {
    func fetchDish(product: [Product])
    func didUpdateSuccessfully()
}

final class AdminPageVC: UIViewController {
    
    // MARK: - UI Elements
    private var allMainDishButton: UIButton!
    private var allDrinkButton: UIButton!
    private var allColdDrinkButton: UIButton!
    private var allSnackButton: UIButton!
    private var allDessertButton: UIButton!
    private var addNewProductButton: UIButton!
    private var openButton: UIButton!
    private var closeButton: UIButton!
    private var indicator: UIActivityIndicatorView!
    
    
    // MARK: - Properties
    private var isRestaurantOpen: Bool?
    private var viewModel = AdminPageViewModel()
    
    override func viewDidLoad() {
        createUI()
        setupRightBarButton()
        getRestaurantStatusFromLocal()
        changeRestaurantStatus()
    }
    
    
    private func getRestaurantStatusFromLocal() {
        isRestaurantOpen = UserDefaultsManager.shared.getRestaurantStatus()
    }
    
    
    
    private func createUI() {
        
        view.backgroundColor = .black
        
        // MARK: - Main Dish Button
        allMainDishButton = UIButton()
        allMainDishButton.setTitle("🍽️ Ana Yemek", for: .normal)
        allMainDishButton.backgroundColor = .white.withAlphaComponent(0.15)
        allMainDishButton.layer.cornerRadius = 15
        
        view.addSubview(allMainDishButton)
        allMainDishButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            allMainDishButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            allMainDishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            allMainDishButton.heightAnchor.constraint(equalToConstant: 125),
            allMainDishButton.widthAnchor.constraint(equalToConstant: 125)
        ])
        
        allMainDishButton.addTarget(self, action: #selector(sendUpdateVC(_:)), for: .touchUpInside)
        
        allSnackButton = UIButton()
        allSnackButton.setTitle("🥗 Mezeler", for: .normal)
        allSnackButton.backgroundColor = .white.withAlphaComponent(0.15)
        allSnackButton.layer.cornerRadius = 15
        
        view.addSubview(allSnackButton)
        allSnackButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            allSnackButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            allSnackButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            allSnackButton.heightAnchor.constraint(equalToConstant: 125),
            allSnackButton.widthAnchor.constraint(equalToConstant: 125)
        ])
        
        allSnackButton.addTarget(self, action: #selector(sendUpdateVC(_:)), for: .touchUpInside)
        
        allDessertButton = UIButton()
        allDessertButton.setTitle("🍩 Tatlılar", for: .normal)
        allDessertButton.backgroundColor = .white.withAlphaComponent(0.15)
        allDessertButton.layer.cornerRadius = 15
        
        view.addSubview(allDessertButton)
        allDessertButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            allDessertButton.topAnchor.constraint(equalTo: allSnackButton.bottomAnchor, constant: 70),
            allDessertButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            allDessertButton.heightAnchor.constraint(equalToConstant: 125),
            allDessertButton.widthAnchor.constraint(equalToConstant: 125)
        ])
        
        allDessertButton.addTarget(self, action: #selector(sendUpdateVC(_:)), for: .touchUpInside)
        
        allDrinkButton = UIButton()
        allDrinkButton.setTitle("☕️ İçecekler", for: .normal)
        allDrinkButton.backgroundColor = .white.withAlphaComponent(0.15)
        allDrinkButton.layer.cornerRadius = 15
        
        view.addSubview(allDrinkButton)
        allDrinkButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            allDrinkButton.topAnchor.constraint(equalTo: allMainDishButton.bottomAnchor, constant: 70),
            allDrinkButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            allDrinkButton.heightAnchor.constraint(equalToConstant: 125),
            allDrinkButton.widthAnchor.constraint(equalToConstant: 125)
        ])
        
        allDrinkButton.addTarget(self, action: #selector(sendUpdateVC(_:)), for: .touchUpInside)
        
        allColdDrinkButton = UIButton()
        allColdDrinkButton.setTitle("🥤 İçecekler", for: .normal)
        allColdDrinkButton.backgroundColor = .white.withAlphaComponent(0.15)
        allColdDrinkButton.layer.cornerRadius = 15
        
        view.addSubview(allColdDrinkButton)
        allColdDrinkButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            allColdDrinkButton.topAnchor.constraint(equalTo: allDrinkButton.bottomAnchor, constant: 70),
            allColdDrinkButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            allColdDrinkButton.heightAnchor.constraint(equalToConstant: 125),
            allColdDrinkButton.widthAnchor.constraint(equalToConstant: 125)
        ])
        
        allColdDrinkButton.addTarget(self, action: #selector(sendUpdateVC(_:)), for: .touchUpInside)
        
        
        // MARK: - Open Button
        openButton = UIButton()
        openButton.backgroundColor = .systemGreen
        openButton.setTitle("Açık", for: .normal)
        openButton.setTitleColor(.black, for: .normal)
        openButton.layer.cornerRadius = 20
        
        view.addSubview(openButton)
        openButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            openButton.topAnchor.constraint(equalTo: allDessertButton.bottomAnchor, constant: 75),
            openButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            openButton.heightAnchor.constraint(equalToConstant: 50),
            openButton.widthAnchor.constraint(equalToConstant: 125)
        ])
        
        
        // MARK: - Close Button
        closeButton = UIButton()
        closeButton.backgroundColor = .white.withAlphaComponent(0.15)
        closeButton.setTitle("Kapalı", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.layer.cornerRadius = 20
        
        view.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: openButton.bottomAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            closeButton.heightAnchor.constraint(equalToConstant: 50),
            closeButton.widthAnchor.constraint(equalToConstant: 125)
        ])
        
        closeButton.addTarget(self, action: #selector(setRestaurantStatusIsOff), for: .touchUpInside)
        openButton.addTarget(self, action: #selector(setRestaurantStatusIsOn), for: .touchUpInside)
        
    }
    
    @objc private func clickedAddNewProductButton() {
        let newProductVC = NewProductViewController()
        self.navigationController?.pushViewController(newProductVC, animated: true)
    }
    
    private func setupRightBarButton() {
        let favoriteImage: UIImage = .init(systemName: "video.circle.fill")!.withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: favoriteImage, style: .done, target: self, action: #selector(clickedVideoRightBarButtonItem))
    }
    
    @objc
    private func clickedVideoRightBarButtonItem() {
        
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .videos
        let pickerViewController = PHPickerViewController(configuration: configuration)
        pickerViewController.delegate = self
        present(pickerViewController, animated: true)
        
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
        case allColdDrinkButton:
            updateProductVC.selectedProduct = "AllDrink"
            
        default:
            break
        }
        
        self.navigationController?.pushViewController(updateProductVC, animated: true)
    }
    
    @objc func setRestaurantStatusIsOn() {
        isRestaurantOpen = true
        changeRestaurantStatus()
        viewModel.saveRestaurantStatus(status: true)
        UserDefaultsManager.shared.saveRestaurantStatus(status: isRestaurantOpen!)
        
    }
    
    @objc func setRestaurantStatusIsOff() {
        isRestaurantOpen = false
        viewModel.saveRestaurantStatus(status: false)
        changeRestaurantStatus()
        UserDefaultsManager.shared.saveRestaurantStatus(status: isRestaurantOpen!)
    }
    
    private func changeRestaurantStatus() {
        DispatchQueue.main.async {
            if self.isRestaurantOpen! {
                self.openButton.backgroundColor = .systemGreen
                self.closeButton.backgroundColor = .white.withAlphaComponent(0.15)
                self.openButton.setTitleColor(.black, for: .normal)
                
            } else {
                self.openButton.backgroundColor = .white.withAlphaComponent(0.15)
                self.closeButton.backgroundColor = .systemRed
                self.openButton.setTitleColor(.white, for: .normal)
            }
        }
    }
    
    private func showMessage() {
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Başarılı", message: "Ürün güncellendi", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Tamam", style: .default)
            alertController.addAction(okButton)
            
            self.present(alertController, animated: true)
        }
    }
}

extension AdminPageVC: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard !results.isEmpty else { return }
        
        results.forEach { result in
            result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.movie.identifier) { url, error in
                guard let url = url else { return }
                
                do {
                    self.showLoadingIndicator()
                    let videoData = try Data(contentsOf: url)
                    FirebaseManager.shared.uploadVideo(videoName: "Daily", videoData: videoData, child: "DailyMenuVideo") { result in
                        switch result {
                        case .success(let success):
                            self.stopLoadingIndicator()
                        case .failure(let failure):
                            print("Failure : \(failure)")
                            self.stopLoadingIndicator()
                        }
                    }
                } catch {
                    self.stopLoadingIndicator()
                    fatalError("Error")
                }
            }
        }
        
    }
    
    private func showLoadingIndicator() {
        
        DispatchQueue.main.async { [self] in
            view.isUserInteractionEnabled = false
            
            indicator = UIActivityIndicatorView(style: .large)
            
            view.addSubview(indicator)
            indicator.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
            indicator.startAnimating()
        }
        
    }
    
    private func stopLoadingIndicator() {
        DispatchQueue.main.async { [self] in
            indicator.stopAnimating()
            indicator.removeFromSuperview()
            view.isUserInteractionEnabled = true
        }
    }
}

extension AdminPageVC: AdminPageProtocol {
    func fetchDish(product: [Product]) {
        
    }
    func didUpdateSuccessfully() {
        showMessage()
    }
}
