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
    private let userDefaults = UserDefaults.standard
    private init() {}

}

extension UserDefaultsManager: UserDefaultsManageable {
    
        
    // MARK: - Checking user type (Admin or Student)
    func saveAUserTypeData(value: Bool) {
        userDefaults.set(value, forKey: "isAdmin")
    }
    
    func getUserTypeData() -> Bool {
        guard let userType = userDefaults.value(forKey: "isAdmin") as? Bool else { return false }
        return userType
    }
    
    // MARK: - Checking onboarding seen
    func getOnboardingSeenData() -> Bool {
        guard let isOnboardingSeen = userDefaults.value(forKey: "isOnboardingSeen") as? Bool else { return false }
        return isOnboardingSeen
    }
    
    func saveOnboardingSeenData(value: Bool) {
        userDefaults.set(value, forKey: "isOnboardingSeen")
    }
    
    func saveRestaurantStatus(status: Bool) {
        userDefaults.set(status, forKey: "restaurantStatus")
    }
    
    func getRestaurantStatus() -> Bool {
        guard let restaurantStatus = userDefaults.value(forKey: "restaurantStatus") as? Bool else { return true }
        return restaurantStatus
    }
}
