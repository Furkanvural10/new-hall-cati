//
//  GetDailyDessert.swift
//  New Hall Cati
//
//  Created by furkan vural on 10.01.2024.
//

import Foundation

protocol GetDailyDessertProtocol {
    func getDailyDessert(child: String, completion: @escaping (Result<[Product], NetworkError>) -> Void)
}

final class GetDailyDessert: GetDailyDessertProtocol {
    
    static let shared = GetDailyDessert()
    private init() {}
    
    func getDailyDessert(child: String, completion: @escaping (Result<[Product], NetworkError>) -> Void) {
        FirebaseManager.shared.getData(child: child, completion: completion)
    }
    
}
