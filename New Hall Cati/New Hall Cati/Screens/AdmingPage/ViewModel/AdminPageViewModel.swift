//
//  AdminPageViewModel.swift
//  New Hall Cati
//
//  Created by furkan vural on 3.01.2024.
//

import Foundation

protocol AdminPageViewModelProtocol {
    
    func saveNewMenu()
    func getAllMainDish()
    func getAllDessert()
    func getAllDrink()
    func getAllSnack()
}

class AdminPageViewModel {
    var allMainDish: [Product]!
    var allDrink: [Product]!
    var allSnack: [Product]!
    var allDessert: [Product]!
    
    weak var delegate: AdminPageProtocol?
}

extension AdminPageViewModel: AdminPageViewModelProtocol {
    
    
    
    func saveNewMenu() {
//        TODO: save db admin adding new daily menu
    }
    
    func getAllMainDish() {
        GetAllMainDish.shared.getAllDish(child: "AllMainDish") { result in
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
}
