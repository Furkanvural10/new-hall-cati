//
//  GetAllDessert.swift
//  New Hall Cati
//
//  Created by furkan vural on 11.01.2024.
//

import Foundation

protocol GetAllDessertProtocol {
    func getAllDessert(child: String, completion: @escaping (Result<[Product], NetworkError>) -> Void)
}

final class GetAllDessert: GetAllDessertProtocol {
    
    static let shared = GetAllDessert()
    private init() {}
    
    func getAllDessert(child: String, completion: @escaping (Result<[Product], NetworkError>) -> Void) {
        FirebaseManager.shared.getData(child: child, completion: completion)
    }
}
