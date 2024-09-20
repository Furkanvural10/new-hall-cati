//
//  FavoriteProductViewModel.swift
//  New Hall Cati
//
//  Created by furkan vural on 29.08.2024.
//

import Foundation


protocol FavoriteProductViewModelProtocol {
    func getFavoriteProductFromFirebase()
}


final class FavoriteProductViewModel {
    
}

extension FavoriteProductViewModel: FavoriteProductViewModelProtocol {
    
    func getFavoriteProductFromFirebase() {
        FirebaseManager.shared
    }
}
