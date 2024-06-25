//
//  NewOnboardingVC.swift
//  New Hall Cati
//
//  Created by Emirhan İpek on 9.06.2024.
//

import UIKit

final class NewOnboardingVC: UIViewController {
    
    
    // MARK: - UI Elements
    private var mainBackgroundImageView: UIImageView!
    private var mainTitleLabel: UILabel!
    private var studentLoginButton: UIButton!
    private var adminNumberTextField: UITextField!
    private var adminLoginLabel: UILabel!
    private var studentLoginLabel: UILabel!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGestureRecognizers()
    }
    
    
    // MARK: - Prepare UI
    private func setupUI() {
        
        // Background Image Configuration
        mainBackgroundImageView = UIImageView()
        mainBackgroundImageView.image = UIImage(named: "OnboardingBackground")
        
        view.addSubview(mainBackgroundImageView)
        mainBackgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainBackgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            mainBackgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainBackgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mainBackgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor)]
        )
        
        // Main Title Configuration
        mainTitleLabel = UILabel()
        mainTitleLabel.text = "New Hall Çatı"
        mainTitleLabel.font = UIFont.pacificoRegular(size: 30)
        mainTitleLabel.textColor = .white
        
        view.addSubview(mainTitleLabel)
        mainTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainTitleLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
            mainTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        //  Student Login Button Configuration
        studentLoginButton = UIButton()
        studentLoginButton.configuration = .filled()
        studentLoginButton.configuration?.title = "Öğrenci Girişi"
        studentLoginButton.configuration?.attributedTitle?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        studentLoginButton.configuration?.titleAlignment = .center
        studentLoginButton.configuration?.cornerStyle = .large
        studentLoginButton.configuration?.baseBackgroundColor = .systemOrange
        studentLoginButton.configuration?.baseForegroundColor = .black
        studentLoginButton.contentHorizontalAlignment = .center
        
        view.addSubview(studentLoginButton)
        studentLoginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            studentLoginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.045),
            studentLoginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            studentLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            studentLoginButton.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 30)
        ])
        
        // Admin Number Text Field Configuration
        adminNumberTextField = UITextField()
        adminNumberTextField.placeholder = "Üye Numarası"
        adminNumberTextField.borderStyle = .roundedRect
        adminNumberTextField.autocorrectionType = .no
        adminNumberTextField.keyboardType = .numberPad
        adminNumberTextField.backgroundColor = .systemGray5
        adminNumberTextField.delegate = self
        
        let placeholderText = "Üye Numarası"
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 12, weight: .bold)
        ]
        adminNumberTextField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: placeholderAttributes)
        
        view.addSubview(adminNumberTextField)
        adminNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        adminNumberTextField.isHidden = true
        
        NSLayoutConstraint.activate([
            adminNumberTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.045),
            adminNumberTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            adminNumberTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            adminNumberTextField.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 30)]
        )
        
        // MARK: - Admin Login Label Configuration
        adminLoginLabel = UILabel()
        adminLoginLabel.setUnderlinedText("Üye Girişi")
        adminLoginLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        adminLoginLabel.textColor = .white
        
        view.addSubview(adminLoginLabel)
        adminLoginLabel.translatesAutoresizingMaskIntoConstraints = false
        adminLoginLabel.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            adminLoginLabel.topAnchor.constraint(equalTo: studentLoginButton.bottomAnchor, constant: 30),
            adminLoginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Student Login Label Configuration
        studentLoginLabel = UILabel()
        studentLoginLabel.setUnderlinedText("Öğrenci olarak devam et")
        studentLoginLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        studentLoginLabel.textColor = .white
        
        view.addSubview(studentLoginLabel)
        studentLoginLabel.translatesAutoresizingMaskIntoConstraints = false
        studentLoginLabel.isUserInteractionEnabled = true
        studentLoginLabel.isHidden = true
        
        NSLayoutConstraint.activate([
            studentLoginLabel.topAnchor.constraint(equalTo: studentLoginButton.bottomAnchor, constant: 30),
            studentLoginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    // MARK: - Gesture Recognizers Functions
    private func setupGestureRecognizers() {
        let adminLoginTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleAdminLoginTap))
        adminLoginLabel.addGestureRecognizer(adminLoginTapGesture)
        
        let studentLoginTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleStudentLoginTap))
        studentLoginLabel.addGestureRecognizer(studentLoginTapGesture)
    }
    
    
    @objc private func handleAdminLoginTap() {
        UIView.animate(withDuration: 0.3) {
            self.adminLoginLabel.alpha = 0
            self.studentLoginButton.alpha = 0
        } completion: { _ in
            self.adminLoginLabel.isHidden = true
            self.studentLoginButton.isHidden = true
            self.adminNumberTextField.isHidden = false
            self.studentLoginLabel.isHidden = false
            
            UIView.animate(withDuration: 0.3) {
                self.adminNumberTextField.alpha = 1
                self.studentLoginLabel.alpha = 1
            }
        }
    }
    
    @objc private func handleStudentLoginTap() {
        UIView.animate(withDuration: 0.3) {
            self.adminNumberTextField.alpha = 0
            self.studentLoginLabel.alpha = 0
        } completion: { _ in
            self.adminNumberTextField.isHidden = true
            self.studentLoginLabel.isHidden = true
            self.adminLoginLabel.isHidden = false
            self.studentLoginButton.isHidden = false
            
            UIView.animate(withDuration: 0.3) {
                self.adminLoginLabel.alpha = 1
                self.studentLoginButton.alpha = 1
            }
        }
    }
}

extension NewOnboardingVC: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
    }
    
    
}
