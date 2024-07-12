//
//  GetMainDish.swift
//  New Hall Cati
//
//  Created by furkan vural on 10.01.2024.
//

import Foundation

protocol GetMainDishProtocol {
    func getMainDish(child: String, completion: @escaping (Result<[Product], NetworkError>) -> Void)
}

final class GetMainDish: GetMainDishProtocol {
    
    static let shared = GetMainDish()
    private init() {}
    
    func getMainDish(child: String, completion: @escaping (Result<[Product], NetworkError>) -> Void) {
        FirebaseManager.shared.getData(child: child, completion: completion)
    }
    
    
    
}
