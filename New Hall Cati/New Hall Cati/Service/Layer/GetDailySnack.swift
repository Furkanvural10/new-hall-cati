//
//  GetDailyNut.swift
//  New Hall Cati
//
//  Created by furkan vural on 11.01.2024.
//

import Foundation

protocol GetDailySnackProtocol {
    func getDailySnack(child: String, completion: @escaping (Result<[Product], NetworkError>) -> Void)
}

final class GetDailySnack: GetDailySnackProtocol {
    
    static let shared = GetDailySnack()
    private init() {}
    
    func getDailySnack(child: String, completion: @escaping (Result<[Product], NetworkError>) -> Void) {
        FirebaseManager.shared.getData(child: child, completion: completion)
    }
}
