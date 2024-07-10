//
//  NewOnboardingViewModel.swift
//  New Hall Cati
//
//  Created by Emirhan İpek on 9.06.2024.
//

import Foundation
import Firebase

protocol OnboardingViewControllable: AnyObject {
    func didRequestLogin()
    func didCatchError()
}


protocol OnboardingVMProtocol {
    func loginAnonymousUser()
    func loginAdmin(_ adminPassword: String)
    func saveOnboardingSeenData()
}

final class OnboardingViewModel {
    weak var delegate: OnboardingViewControllable?
    private var firebaseManager: FirebaseManager = .shared
}

extension OnboardingViewModel: OnboardingVMProtocol {
    
    func loginAnonymousUser() {
        
        firebaseManager.createAnonymousUser { result in
            switch result {
            case .success(_):
                self.saveAdminValue(value: false)
                self.delegate?.didRequestLogin()
            case .failure(_):
                self.delegate?.didCatchError()
                break
            }
        }
    }
    func loginAdmin(_ adminPassword: String) {
        firebaseManager.loginAdmin(adminPassword: adminPassword) { result in
            switch result {
            case true:
                self.saveAdminValue(value: true)
                self.delegate?.didRequestLogin()
            case false:
                self.delegate?.didCatchError()
                break
            }
        }
    }
    
    private func saveAdminValue(value: Bool) {
        UserDefaultsManager.shared.saveAUserTypeData(value: value)
    }
    
    func saveOnboardingSeenData() {
        UserDefaultsManager.shared.saveOnboardingSeenData(value: true)
    }
    
}
