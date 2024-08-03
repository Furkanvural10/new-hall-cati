//
//  DatePickerView.swift
//  New Hall Cati
//
//  Created by furkan vural on 18.01.2024.
//

import Foundation
import UIKit

class CustomWorkingHourView: UIViewController {
    
    let containerView = UIView()
    let firstTextField: UITextField = {
        var firstTextField = UITextField()
        firstTextField.borderStyle = .roundedRect
        firstTextField.placeholder = "Açılış: 08.00"
        firstTextField.keyboardType = .decimalPad
        return firstTextField
    }()
    
    let secondTextField: UITextField = {
        var secondTextField = UITextField()
        secondTextField.placeholder = "Kapanış: 19.00"
        secondTextField.borderStyle = .roundedRect
        secondTextField.keyboardType = .decimalPad
        return secondTextField
    }()
    
    let saveButton: UIButton = {
        var saveButton = UIButton()
        saveButton.setTitle("Kaydet", for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.layer.cornerRadius = 10
        return saveButton
    }()
    
    let cancelButton: UIButton = {
        var cancelButton = UIButton()
        cancelButton.setTitle("İptal", for: .normal)
        cancelButton.backgroundColor = .systemRed
        cancelButton.layer.cornerRadius = 10
        return cancelButton
    }()
    
    var alertTitle: String?
    
    init(alertTitle: String?) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        configureContainer()
        configureTextFields()
        configureButtons()
    }
    
    func configureContainer() {
        view.addSubview(containerView)
        containerView.backgroundColor = .black
        containerView.layer.cornerRadius = 10
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.23)
        ])
        
    }
    
    func configureTextFields() {
        
        containerView.addSubview(firstTextField)
        containerView.addSubview(secondTextField)
        
        firstTextField.translatesAutoresizingMaskIntoConstraints = false
        secondTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            firstTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            firstTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            firstTextField.heightAnchor.constraint(equalToConstant: 30),
            
            secondTextField.topAnchor.constraint(equalTo: firstTextField.bottomAnchor, constant: 15),
            secondTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            secondTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            secondTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureButtons() {
        containerView.addSubview(saveButton)
        containerView.addSubview(cancelButton)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: secondTextField.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: containerView.centerXAnchor, constant: -5),
            saveButton.heightAnchor.constraint(equalToConstant: 30),
            
            cancelButton.topAnchor.constraint(equalTo: saveButton.topAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 5),
            cancelButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            cancelButton.heightAnchor.constraint(equalTo: saveButton.heightAnchor)
        ])
        
        saveButton.addTarget(self, action: #selector(saveWorkingHour), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        
    }
    
    @objc private func close() {
        self.dismiss(animated: true)
    }
    
    @objc private func saveWorkingHour() {
        guard firstTextField.text != "",
              secondTextField.text != "" else {
            self.dismiss(animated: true)
            return
        }
        let mainPageViewModel = MainPageViewModel()
//        mainPageViewModel.saveWorkingHour(openingTime: firstTextField.text!, closingTime: secondTextField.text!)
        self.dismiss(animated: true)
    }
    
    
    
}
