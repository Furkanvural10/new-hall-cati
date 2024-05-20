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
    
    private var productNameTextField: UITextField!
    private var productPriceTextField: UITextField!
    private var uploadImageButton: UIButton!
    private var saveProductButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureTextFields()
        setupTextFieldDelegation()
        configureUploadImageButton()
        configureSaveProductButton()
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

    
    func saveNewProduct() {
        // TODO: - 1) Validation
        // TODO: - 2) Save DB
        // TODO: - 3) Dismiss
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
        let barButton = UIBarButtonItem(title: "Kaydet", style: .plain, target: self, action: #selector(clickedRightBarButton))
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc private func clickedRightBarButton() {
        saveNewProduct()
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
        self.dismiss(animated: true)
    }
    
    
}
