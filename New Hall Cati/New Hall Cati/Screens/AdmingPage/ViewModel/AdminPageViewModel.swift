//
//  AdminPageViewModel.swift
//  New Hall Cati
//
//  Created by furkan vural on 3.01.2024.
//

import Foundation

protocol AdminPageViewModelProtocol: AnyObject {
    
    func saveNewMenu(productList: Set<Product>, selectedProduct: String)
    func getAllMainDish(product: String)
    func getAllDessert()
    func getAllDrink()
    func getAllSnack()
    func updateProduct(product: Product, selectedProduct: String, newValue: Int)
    
}

final class AdminPageViewModel {
    var allMainDish: [Product]!
    var allDrink: [Product]!
    var allSnack: [Product]!
    var allDessert: [Product]!
    
    weak var delegate: AdminPageProtocol?
}

extension AdminPageViewModel: AdminPageViewModelProtocol {
    
    
    func saveNewMenu(productList: Set<Product>, selectedProduct: String) {
        print(productList.map({ $0.name }))
        FirebaseManager.shared.deleteAllDocuments(selectedProduct: selectedProduct, batchSize: 20) { error in
            guard error == nil else {
                return
            }
   
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            productList.forEach {
                FirebaseManager.shared.saveMenu(product: $0, selectedProduct: selectedProduct)
            }
        }
        
    }
    
    
    func getAllMainDish(product: String) {
        
        GetAllMainDish.shared.getAllDish(child: product) { result in
            switch result {
            case .success(let success):
                self.allMainDish = success
                self.delegate?.fetchDish(product: success)
            case .failure(let failure):
                print("failure all main \(failure)")
            }
        }
    }
    
    func getAllDessert() {
        GetAllDessert.shared.getAllDessert(child: "AllDessert") { result in
            switch result {
            case .success(let success):
                self.allDessert = success
            case .failure(let failure):
                print("failure all dessert \(failure)")
            }
        }
    }
    
    func getAllDrink() {
        GetAllDrink.shared.getAllDrink(child: "AllDrink") { result in
            switch result {
            case .success(let success):
                self.allDrink = success
            case .failure(let failure):
                print("failure all drink \(failure)")
            }
        }
    }
    
    func getAllSnack() {
        GetAllSnack.shared.getAllSnack(child: "AllSnack") { result in
            switch result {
            case .success(let success):
                self.allSnack = success
            case .failure(let failure):
                print("failure all snack \(failure)")
            }
        }
    }
    
    func updateProduct(product: Product, selectedProduct: String, newValue: Int) {
        
        FirebaseManager.shared.updateProduct(product: product, selectedProduct: selectedProduct, newValue: newValue) { result in
            switch result {
            case true:
                self.delegate?.didUpdateSuccessfully()
            case false:
                break
            }
        }
    }
    
    func saveRestaurantStatus(status: Bool) {
        FirebaseManager.shared.saveRestaurantStatus(status: status)
    }
}
