import UIKit

final class OnboardingVC: UIViewController {
    
    private let viewModel = OnboardingViewModel()
    var welcomeTextLabel: UILabel!
    private let padding: CGFloat = 20
    private let fontSize: CGFloat = 35
    private let minimumScaleFactor: Double = 0.7
    private let textLabelHeight: CGFloat = 200

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureWelcomeTextLabel()
        startAnimation()
    }
    
    private func setupUI() { view.backgroundColor = .systemBackground }
    
    private func configureWelcomeTextLabel() {
        
        welcomeTextLabel = UILabel(frame: .zero)
        view.addSubview(welcomeTextLabel)
        welcomeTextLabel.alpha = 0
        welcomeTextLabel.font = UIFont.systemFont(ofSize: fontSize)
        welcomeTextLabel.minimumScaleFactor = minimumScaleFactor
        welcomeTextLabel.contentMode = .center
        welcomeTextLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            welcomeTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeTextLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            welcomeTextLabel.heightAnchor.constraint(equalToConstant: textLabelHeight),
        ])
    }
    
    
    private func startAnimation() {

        UIView.animate(withDuration: 4, delay: 0, options: .curveEaseOut) {
            self.welcomeTextLabel.alpha = 0
        } completion: { _ in
            self.welcomeTextLabel.text = Constant.welcomeText
            UIView.animate(withDuration: 5, delay: 0, options: .curveEaseOut) {
                self.welcomeTextLabel.alpha = 1
            }
        }
    }
}
