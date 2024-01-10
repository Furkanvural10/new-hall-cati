//
//  GetAllDrink.swift
//  New Hall Cati
//
//  Created by furkan vural on 10.01.2024.
//

import Foundation

protocol GetAllDrinkProtocol {
    func getAllDrink(child: String, completion: @escaping (Result<[Product], NetworkError>) -> Void)
                                    
}

struct GetAllDrink: GetAllDrinkProtocol {
    
    static let shared = GetAllDrink()
    
    private init() {}
    
    func getAllDrink(child: String, completion: @escaping (Result<[Product], NetworkError>) -> Void) {
        FirebaseManager.shared.getData(child: child, completion: completion)
    }
}
