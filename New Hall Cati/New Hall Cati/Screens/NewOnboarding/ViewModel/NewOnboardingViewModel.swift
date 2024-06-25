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
}


protocol NewOnboardingVMProtocol {
    func loginAnonymousUser()
    func loginAdmin()
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
                self.delegate?.didRequestAdminLogin()
            }
        }   
    }
    
    func loginAdmin() {
        
        firebaseManager.loginAdmin(adminPassword: "123456") { result in
            switch result {
            case true:
                self.delegate?.didRequestUserLogin()
            case false:
                break
            }
        }
    }
}
