//
//  OnboardingViewModel.swift
//  New Hall Cati
//
//  Created by furkan vural on 28.12.2023.
//

import Foundation
import UIKit
import Lottie

protocol SplashViewModelDelegate: AnyObject {
    func welcomeTextDidChanged(to newText: String)
    func nextOnboardingPage()
    func nextMainPage()
    
}

struct SplashViewModel {
    
    weak var delegate: SplashViewModelDelegate?
    let welcomeText = Constant.welcomeText
    
    func startAnimation(for label: UILabel, animation: LottieAnimationView) {
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut) {
            
            label.textColor = .white
            label.alpha = 0
            animation.alpha = 0
            
        } completion: { _ in
            self.delegate?.welcomeTextDidChanged(to: self.welcomeText)
            
            UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut) {
                label.alpha = 1
                animation.alpha = 1
                animation.play()
                
            } completion: { _ in
                UIView.animate(withDuration: 1.2, delay: 0, options: .curveEaseOut) {
                    label.alpha = 0
                    animation.alpha = 0
                    
                } completion: { _ in
                    animation.stop()
                    checkSeenOnboarding()
                    
                }
            }
        }
    }
    
    private func checkSeenOnboarding() {
        UserDefaultsManager.shared.getOnboardingSeenData() ? delegate?.nextMainPage() : delegate?.nextOnboardingPage()
    }
    
}
