//
//  NewProductViewController.swift
//  New Hall Cati
//
//  Created by furkan vural on 16.05.2024.
//

import UIKit

protocol NewProductProtocol {
    func setupTextFieldDelegation()
    func saveNewProduct()
    func configureTextFields()
    func configureSaveProductButton()
    func configureUploadImageButton()
    
}

final class NewProductViewController: UIViewController {
    
    // MARK: - UI Elements
    private var productNameTextField: UITextField!
    private var productPriceTextField: UITextField!
    private var uploadImageButton: UIButton!
    private var saveProductButton: UIButton!
    private var uploadingProcessView: UIActivityIndicatorView!
    private var barButton: UIBarButtonItem!
    
    var dishType: String?
    let viewModel = NewProductViewModel()
    var imageData: Data?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        viewModel.delegate = self
        configureTextFields()
        setupTextFieldDelegation()
        configureUploadImageButton()
        configureSaveProductButton()
        configureTypeOfDishOption()
        configureUploadingProcess()
    }
    

}

extension NewProductViewController: NewProductProtocol {
    
    func setupTextFieldDelegation() {
        productNameTextField.delegate = self
        
    }
    
    func configureUploadImageButton() {
        
        uploadImageButton = UIButton()
        uploadImageButton.setImage(UIImage(named: "upload"), for: .normal)
        uploadImageButton.layer.cornerRadius = 10
        
        
        view.addSubview(uploadImageButton)
        uploadImageButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            uploadImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uploadImageButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            uploadImageButton.widthAnchor.constraint(equalToConstant: 120),
            uploadImageButton.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        uploadImageButton.addTarget(self, action: #selector(openImageGallery), for: .touchUpInside)
    }
    
    
    private func configureUploadingProcess() {
        
        uploadingProcessView = UIActivityIndicatorView()
        uploadingProcessView.style = .large
        
        view.addSubview(uploadingProcessView)
        uploadingProcessView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            uploadingProcessView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uploadingProcessView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }

    
    func saveNewProduct() {
        
        barButton.isEnabled = false
        productNameTextField.isEnabled = false
        productPriceTextField.isEnabled = false
        uploadImageButton.isEnabled = false
        view.isUserInteractionEnabled = false
        uploadingProcessView.startAnimating()
        
        let prodID = UUID().uuidString
        let product = Product(prodID: prodID, name: productNameTextField.text!, price: productPriceTextField.text!, image: "")
        guard let imageData else {
            return
        }
        
        viewModel.saveNewProduct(product: product, dishType: dishType!, imageData: imageData)
        
        
        
    }
    
    @objc private func openImageGallery() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.isEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func configureTextFields() {
        
        // MARK: - Product Name TextField Configuration
        productNameTextField = UITextField()
        productNameTextField.borderStyle = .roundedRect
        productNameTextField.placeholder = "Ürün Adı"
        productNameTextField.backgroundColor = .white.withAlphaComponent(0.1)
        productNameTextField.layer.cornerRadius = 10
        
        view.addSubview(productNameTextField)
        productNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productNameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            productNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            productNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            productNameTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.045)
        ])
        
        // MARK: - Product Name TextField Configuration
        productPriceTextField = UITextField()
        productPriceTextField.borderStyle = .roundedRect
        productPriceTextField.placeholder = "Ürün Fiyatı"
        productPriceTextField.keyboardType = .numberPad
        productPriceTextField.backgroundColor = .white.withAlphaComponent(0.1)
        productPriceTextField.layer.cornerRadius = 10
        
        
        
        view.addSubview(productPriceTextField)
        productPriceTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productPriceTextField.topAnchor.constraint(equalTo: productNameTextField.bottomAnchor, constant: 10),
            productPriceTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            productPriceTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            productPriceTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.045)
        ])
    }
    
    func configureSaveProductButton() {
        barButton = UIBarButtonItem(title: "Kaydet", style: .plain, target: self, action: #selector(clickedRightBarButton))
        
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    private func configureTypeOfDishOption() {
        
    }
    
    @objc private func clickedRightBarButton() {
        saveNewProduct()
    }
    
    private func showMessage() {
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Başarılı", message: "Yeni ürün başarılı şekilde eklendi", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Tamam", style: .default) { _ in
                self.navigationController?.popViewController(animated: true)
            }
            alertController.addAction(okButton)
            
            self.present(alertController, animated: true)
        }
    }
    
    
    

}

extension NewProductViewController: UITextFieldDelegate {
    
    // MARK: - When Clicked the Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case productNameTextField:
            productPriceTextField.becomeFirstResponder()
        case productPriceTextField:
            productPriceTextField.resignFirstResponder()
        default:
            break
        }
        return false
    }
}

extension NewProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadImageButton.setImage(info[.originalImage] as? UIImage, for: .normal)
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageData = selectedImage.jpegData(compressionQuality: 50)
        }
        self.dismiss(animated: true)
    }
    
    
}


extension NewProductViewController: NewProductVCDelegate {
    func stopAnimationView() {
        uploadingProcessView.stopAnimating()
        showMessage()
        
    }
    
    
}
