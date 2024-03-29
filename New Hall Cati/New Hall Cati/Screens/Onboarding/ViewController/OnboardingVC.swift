import UIKit

final class OnboardingVC: UIViewController {
    
    private var viewModel = OnboardingViewModel()
    
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
        view.addSubview(welcomeTextLabel)
        welcomeTextLabel.alpha = 0
        welcomeTextLabel.font = .pacificoRegular(size: fontSize)
        welcomeTextLabel.minimumScaleFactor = minimumScaleFactor
        welcomeTextLabel.contentMode = .center
        welcomeTextLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            welcomeTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeTextLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            welcomeTextLabel.heightAnchor.constraint(equalToConstant: textLabelHeight),
        ])
    }
}

extension OnboardingVC: OnboardingViewModelDelegate {
    func welcomeTextDidChanged(to newText: String) {
        welcomeTextLabel.text = newText
    }
    
    func nextPage() {
        let mainPage = MainPageVC()
        navigationController?.viewControllers = [mainPage]
    }
    
    func showAlertMessage() {
        let alertController = UIAlertController(title: "Hata", message: "Beklenmedik bir hata oluştu. Lütfen tekrar deneyin", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
}
