//
//  MainPageViewModel.swift
//  New Hall Cati
//
//  Created by furkan vural on 29.12.2023.
//

import Foundation

protocol MainPageViewModelProtocol: AnyObject {
    func setTitle(dateString: String)
}

class MainPageViewModel {
    
    weak var delegate: MainPageViewModelProtocol?
    
    func setTitle() {
        let today = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        formatter.locale = Locale(identifier: "tr_TR")
        let dateString = formatter.string(from: today)
        
        delegate?.setTitle(dateString: dateString)
    }
    
}
