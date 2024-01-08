//
//  FirebaseManager.swift
//  New Hall Cati
//
//  Created by furkan vural on 8.01.2024.
//

import Foundation
import FirebaseAuth

protocol FirebaseManagerProtocol {
    func createAnonymousUser(completion: @escaping ((Result<User, NetworkError>) -> Void))
    func getData()
}


final class FirebaseManager: FirebaseManagerProtocol {
    
    static let shared = FirebaseManager()
    
    private init() {}
    
    func createAnonymousUser(completion: @escaping (Result<User, NetworkError>) -> Void) {
        
        Auth.auth().signInAnonymously { result, error in
            guard error == nil else {
                completion(.failure(.authError))
                return
            }
            guard let result = result else {
                completion(.failure(.authResultError))
                return
            }
            
            let user = User(userID: result.user.uid)
            completion(.success(user))
        }
    }
    
    func getData() {
//      TODO: Get data from firebase
    }
}
