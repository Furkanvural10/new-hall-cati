//
//  NewProductViewModel.swift
//  New Hall Cati
//
//  Created by furkan vural on 12.07.2024.
//

import Foundation

protocol NewProductVMProtocol {
    func saveNewProduct(product: Product, dishType: String, imageData: Data)
}


final class NewProductViewModel {
    
    
}

extension NewProductViewModel: NewProductVMProtocol {
    
    func saveNewProduct(product: Product, dishType: String, imageData: Data) {
        FirebaseManager.shared.uploadImage(imageName: product.name, imageData: imageData, child: dishType) { result in
            switch result {
            case .success(let success):
                let product = Product(prodID: product.prodID, name: product.name, price: product.price, image: success)
                FirebaseManager.shared.addNewProduct(newProduct: product , dishType: dishType) { error in
                    guard error == nil else { return }
                }
            case .failure(let failure):
                break
            }
        }
        
    }
}
