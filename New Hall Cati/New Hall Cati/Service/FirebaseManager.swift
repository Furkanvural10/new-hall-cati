//
//  FirebaseManager.swift
//  New Hall Cati
//
//  Created by furkan vural on 8.01.2024.
//

import Foundation
import FirebaseAuth

protocol FirebaseManagerProtocol {
    func createAnonymousUser()
    func getData()
}

final class FirebaseManager: FirebaseManagerProtocol {
    
    static let shared = FirebaseManager()
    
    private init() {}
    
    func createAnonymousUser() {
//      TODO: Create anon user
        Auth.auth().signInAnonymously { result, error in
            guard error == nil else { return }
            guard let result = result else { return }
            
            print("BAŞARILI \(result.user.uid)")
        }
    }
    
    func getData() {
//      TODO: Get data from firebase
    }
}
