//
//  GetAllNut.swift
//  New Hall Cati
//
//  Created by furkan vural on 11.01.2024.
//

import Foundation

protocol GetAllSnackProtocol {
    func getAllSnack(child: String, completion: @escaping (Result<[Product], NetworkError>) -> Void)
}

final class GetAllSnack: GetAllSnackProtocol {
    
    static let shared = GetAllSnack()
    private init() {}
    
    func getAllSnack(child: String, completion: @escaping (Result<[Product], NetworkError>) -> Void) {
        FirebaseManager.shared.getData(child: child, completion: completion)
    }
}
