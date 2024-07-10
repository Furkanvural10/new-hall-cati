import UIKit

final class SplashVC: UIViewController {
    
    private var viewModel = SplashViewModel()
    
    var welcomeTextLabel: UILabel!
    private let padding: CGFloat = 20
    private let fontSize: CGFloat = 35
    private let minimumScaleFactor: Double = 0.7
    private let textLabelHeight: CGFloat = 200

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupUI()
        configureWelcomeTextLabel()
        viewModel.startAnimation(for: welcomeTextLabel)
    }
    
    private func setupUI() { view.backgroundColor = .black }
    
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
    }
}

extension SplashVC: SplashViewModelDelegate {
    
    func welcomeTextDidChanged(to newText: String) {
        welcomeTextLabel.text = newText
    }
    
    func nextMainPage() {
        let mainPage = MainPageVC()
        navigationController?.viewControllers = [mainPage]
    }
    
    func nextOnboardingPage() {
        let onboardingVC = OnboardingVC()
        navigationController?.pushViewController(onboardingVC, animated: true)
    }
    
}
