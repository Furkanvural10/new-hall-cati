//
//  NewOnboardingViewModel.swift
//  New Hall Cati
//
//  Created by Emirhan İpek on 9.06.2024.
//

import Foundation
import Firebase

protocol NewOnboardingViewControllable: AnyObject {
    func didRequestUserLogin()
    func didRequestAdminLogin()
    func didCatchError()
    
}


protocol NewOnboardingVMProtocol {
    func loginAnonymousUser()
    func loginAdmin(_ adminPassword: String)
}

final class NewOnboardingViewModel {
    
    weak var delegate: NewOnboardingViewControllable?
    private var firebaseManager: FirebaseManager = .shared
    
}

extension NewOnboardingViewModel: NewOnboardingVMProtocol {
    
    func loginAnonymousUser() {
        
        firebaseManager.createAnonymousUser { result in
            switch result {
            case .success(let success):
                self.delegate?.didRequestUserLogin()
            case .failure(let failure):
                // Hata mesajı göster
                break
            }
        }
    }
    func loginAdmin(_ adminPassword: String) {
        firebaseManager.loginAdmin(adminPassword: adminPassword) { result in
            switch result {
            case true:
                self.delegate?.didRequestUserLogin()
            case false:
                // Hata mesajı göster
                self.delegate?.didCatchError()
                break
            }
        }
    }
    
}
