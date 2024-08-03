import UIKit
import Lottie

final class SplashVC: UIViewController {
    
    
    // MARK: - UI Elements
    private var welcomeTextLabel: UILabel!
    private var animation: LottieAnimationView!
    
    
    // MARK: - Properties
    private var viewModel = SplashViewModel()
    private let padding: CGFloat = 20
    private let fontSize: CGFloat = 35
    private let minimumScaleFactor: Double = 0.7
    private let textLabelHeight: CGFloat = 200

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupUI()
        configureWelcomeTextLabel()
        viewModel.startAnimation(for: welcomeTextLabel, animation: animation)
    }
    
    private func setupUI() {
        view.backgroundColor = .black
    }
    
    private func configureWelcomeTextLabel() {
        
        welcomeTextLabel = UILabel(frame: .zero)
        welcomeTextLabel.alpha = 0
        welcomeTextLabel.font = .pacificoRegular(size: fontSize)
        welcomeTextLabel.minimumScaleFactor = minimumScaleFactor
        welcomeTextLabel.contentMode = .center
        
        view.addSubview(welcomeTextLabel)
        welcomeTextLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            welcomeTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeTextLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            welcomeTextLabel.heightAnchor.constraint(equalToConstant: textLabelHeight),
        ])
        
        
        // MARK: - Lottie Animation
        animation = LottieAnimationView(name: "splashAnimation")

        view.addSubview(animation)
        animation.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            animation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animation.topAnchor.constraint(equalTo: welcomeTextLabel.bottomAnchor, constant: -40),
            animation.heightAnchor.constraint(equalToConstant: 200),
            animation.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        
    
    }
}

extension SplashVC: SplashViewModelDelegate {
    
    func welcomeTextDidChanged(to newText: String) {
        welcomeTextLabel.text = newText
        animation.play()
    }
    
    func nextMainPage() {
        animation.stop()
        let mainPage = MainPageVC()
        navigationController?.viewControllers = [mainPage]
    }
    
    func nextOnboardingPage() {
        animation.stop()
        let onboardingVC = OnboardingVC()
        navigationController?.pushViewController(onboardingVC, animated: true)
    }
    
}
