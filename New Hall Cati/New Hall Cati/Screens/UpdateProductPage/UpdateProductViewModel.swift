//
//  UpdateProductViewModel.swift
//  New Hall Cati
//
//  Created by furkan vural on 21.05.2024.
//

import Foundation

protocol UpdateProductProtocol {
    func saveNewProduct(product: Product)
}

final class UpdateProductViewModel {
    
}

extension UpdateProductViewModel: UpdateProductProtocol {
    
    func saveNewProduct(product: Product) {
        
//        FirebaseManager.shared.updateProduct()
    }
}
