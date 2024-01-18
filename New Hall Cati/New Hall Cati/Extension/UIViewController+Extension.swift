//
//  UIViewController+Extension.swift
//  New Hall Cati
//
//  Created by furkan vural on 18.01.2024.
//

import UIKit

extension UIViewController {
    
    func presentDatePickerViewOnMainThread() {
        DispatchQueue.main.async {
            let datePicker = DatePickerView(alertTitle: "Saat Seçiniz")
            datePicker.modalPresentationStyle = .overFullScreen
            datePicker.modalTransitionStyle = .crossDissolve
            self.present(datePicker, animated: true)
        }
    }
}
