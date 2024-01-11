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
}

class AdminPageViewModel {
    
}

extension AdminPageViewModel: AdminPageViewModelProtocol {
    
    func saveNewMenu() {
//        TODO: save db admin adding new daily menu
    }
    
    func getAllMainDish() {
        GetAllMainDish.shared.getAllDish(child: "AllMainDish") { result in
            switch result {
            case .success(let success):
                print("Success \(success)")
            case .failure(let failure):
                print("failure all main")
            }
        }
    }
}
