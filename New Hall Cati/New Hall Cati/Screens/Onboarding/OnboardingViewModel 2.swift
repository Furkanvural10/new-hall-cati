//
//  OnboardingViewModel.swift
//  New Hall Cati
//
//  Created by furkan vural on 28.12.2023.
//

import Foundation
import UIKit

protocol OnboardingViewModelDelegate: AnyObject {
    func welcomeTextDidChanged(to newText: String)
}

struct OnboardingViewModel {
    
    weak var delegate: OnboardingViewModelDelegate?
    let welcomeText = Constant.welcomeText
    
    func startAnimation(for label: UILabel) {
        UIView.animate(withDuration: 5, delay: 0, options: .curveEaseOut) {
            label.alpha = 0
        } completion: { _ in
            self.delegate?.welcomeTextDidChanged(to: self.welcomeText)
            UIView.animate(withDuration: 5, delay: 0, options: .curveEaseOut) {
                label.alpha = 1
            }
        }
    }
    
    
}
