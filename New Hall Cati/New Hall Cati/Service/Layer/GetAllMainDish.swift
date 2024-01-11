//
//  GetAllMainDish.swift
//  New Hall Cati
//
//  Created by furkan vural on 11.01.2024.
//

import Foundation

protocol GetAllMainDishProtocol {
    func getAllDish(child: String, completion: @escaping (Result<[Product], NetworkError>) -> Void)
}

final class GetAllMainDish: GetAllMainDishProtocol {
    
    static let shared = GetAllMainDish()
    
    private init() {}
    
    func getAllDish(child: String, completion: @escaping (Result<[Product], NetworkError>) -> Void) {
        FirebaseManager.shared.getData(child: child, completion: completion)
    }
}
