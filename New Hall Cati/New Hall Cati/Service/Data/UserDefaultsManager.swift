//
//  UserDefaultsManager.swift
//  New Hall Cati
//
//  Created by furkan vural on 9.07.2024.
//

import Foundation

protocol UserDefaultsManageable {
    func saveAUserTypeData(value: Bool)
    func getUserTypeData() -> Bool
    func getOnboardingSeenData() -> Bool
    func saveOnboardingSeenData(value: Bool)
}

final class UserDefaultsManager {

    static let shared: UserDefaultsManager = .init()
    private init() {}

}

extension UserDefaultsManager: UserDefaultsManageable {
    
    
    // MARK: - Checking user type (Admin or Student)
    func saveAUserTypeData(value: Bool) {
        UserDefaults.standard.set(value, forKey: "isAdmin")
    }
    
    func getUserTypeData() -> Bool {
        guard let userType = UserDefaults.standard.value(forKey: "isAdmin") as? Bool else { return false }
        return userType
    }
    
    // MARK: - Checking onboarding seen
    func getOnboardingSeenData() -> Bool {
        guard let isOnboardingSeen = UserDefaults.standard.value(forKey: "isOnboardingSeen") as? Bool else { return false }
        return isOnboardingSeen
    }
    
    func saveOnboardingSeenData(value: Bool) {
        UserDefaults.standard.set(value, forKey: "isOnboardingSeen")
    }
    
    
    
}
