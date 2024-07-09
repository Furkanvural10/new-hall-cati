//
//  AlertMessage.swift
//  New Hall Cati
//
//  Created by furkan vural on 1.07.2024.
//

import Foundation
import UIKit

final class AlertMessage {
    
    static let shared = AlertMessage()
    private init() {}
    
    func showAlertMessage(title: String, subtitle: String, viewController vc: UIViewController) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(okButton)
        vc.present(alert, animated: true)
    }
}
