//
//  NewOnboardingVC.swift
//  New Hall Cati
//
//  Created by Emirhan İpek on 9.06.2024.
//

import UIKit

final class NewOnboardingVC: UIViewController {
    
    private var mainBackgroundImageView: UIImageView!
    private var mainTitleLabel: UILabel!
    private var studentLoginButton: UIButton!
    private var adminLoginLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        // MARK: - Background Image Configuration
        mainBackgroundImageView = UIImageView()
        mainBackgroundImageView.image = UIImage(named: "OnboardingBackground")
        
        view.addSubview(mainBackgroundImageView)
        mainBackgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([mainBackgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
                                     mainBackgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     mainBackgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
                                     mainBackgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor)])
        
        // MARK: - Main Title Configuration
        mainTitleLabel = UILabel()
        mainTitleLabel.text = "New Hall Çatı"
        mainTitleLabel.font = UIFont.pacificoRegular(size: 30)
        mainTitleLabel.textColor = .white
        
        view.addSubview(mainTitleLabel)
        mainTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([mainTitleLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
                                     mainTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        // MARK: - Student Login Button Configuration
        studentLoginButton = UIButton()
        studentLoginButton.configuration = .filled()
        studentLoginButton.configuration?.title = "Öğrenci Girişi"
//        studentLoginButton.configuration?.titleAlignment = .center
        studentLoginButton.configuration?.attributedTitle?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        studentLoginButton.configuration?.image = UIImage(systemName: "arrow.forward")
        studentLoginButton.configuration?.imagePlacement = .trailing
        studentLoginButton.configuration?.imagePadding = 5
        studentLoginButton.configuration?.cornerStyle = .large
        studentLoginButton.configuration?.baseBackgroundColor = .systemOrange
        studentLoginButton.configuration?.baseForegroundColor = .black
        studentLoginButton.contentHorizontalAlignment = .center
        
        view.addSubview(studentLoginButton)
        studentLoginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([studentLoginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.045),
                                     studentLoginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
                                     studentLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     studentLoginButton.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 30)])
        
        // MARK: - Admin Login Label Configuration
        adminLoginLabel = UILabel()
        adminLoginLabel.setUnderlinedText("Üye Girişi")
        adminLoginLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        adminLoginLabel.textColor = .white
        
        view.addSubview(adminLoginLabel)
        adminLoginLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([adminLoginLabel.topAnchor.constraint(equalTo: studentLoginButton.bottomAnchor, constant: 30),
                                     adminLoginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
    }
    
}
