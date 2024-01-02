import UIKit

protocol MainPageProtocol {
    
    func configureBackground()
    func configureTitle()
    func configureDateTitle()
    func configureWorkingLabel()
    func configureHourLabel()
    func configureWorkingDetailView()
    func configureTableView()
    func configureAdminButton()
    func configureSegmentedController()
    
    var viewModel: MainPageViewModel { get }
    var isAdmin: Bool { get }
}

final class MainPageVC: UIViewController, MainPageProtocol {

    var viewModel = MainPageViewModel()
    
    private enum ProductType: String, CaseIterable {
        case dish = "Ana Yemek"
        case drink = "Tatlılar"
        case dessert = "İçecekler"
    }
    private var productTitleList: [ProductType] = [.dish, .drink, .dessert]
    var isAdmin: Bool = true
    
    private var dateTitleLabel: UILabel!
    private var workingTitleLabel: UILabel!
    private var workingHourLabel: UILabel!
    private var workingDetailView: UIView!
    private var segmentedController: UISegmentedControl!
    private var header: TableViewHeader!
    
    // MARK: - Mock Data
    var foods = ["Patlıcan Musakka", "Fırın Tavuk", "Bezelye", "Pirinç Pilavı", "Izgara Köfte", "Ispanak Greten"]
    var drinks = ["Cola", "Fanta", "Ice Tea", "Sade Sode", "Limonlu Soda", "Kahve", "Çay", "Su", "Ayran",]
    var desserts = ["Tiramisu", "Kabak Tatlısı", "Sütlaç", "Pudding"]
    
    var showingList = [String]()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        tableView.register(CellHeader.self, forHeaderFooterViewReuseIdentifier: CellHeader.identifier)
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showingList = foods
        
        // MARK: - Delegates
        viewModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        // MARK: - SetupUI
        
        configureBackground()
        configureTitle()
        configureDateTitle()
        configureWorkingLabel()
        configureHourLabel()
        configureSegmentedController()
        configureTableView()
        configureWorkingDetailView()
        configureAdminButton()
    }
    

    
    func configureBackground() { view.backgroundColor = .white }
    
    func configureTitle() {
        let titleLabel = UILabel()
        titleLabel.text = Constant.welcomeText
        titleLabel.font = UIFont.pacificoRegular(size: 20)
        titleLabel.textColor = .label
        
        self.navigationItem.titleView = titleLabel
    }
    
    func configureDateTitle() {
        dateTitleLabel = UILabel()
        view.addSubview(dateTitleLabel)
        dateTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            dateTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5)
        ])
        viewModel.setTitle()
    }
    
    func configureTableView() {
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.segmentedController.bottomAnchor, constant: 5),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func configureAdminButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constant.adminText, style: .done, target: self, action: #selector(openAdminPage))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc func openAdminPage() {
        print("Admin Sayfasını aç")
        //        let adminPageVC = AdminPageVC()
        //        navigationController?.pushViewController(adminPageVC, animated: true)
    }
    
    
    func configureWorkingLabel() {
        workingTitleLabel = UILabel()
        workingTitleLabel.font = UIFont.boldSystemFont(ofSize: 13)
        workingTitleLabel.text = Constant.openClosedText
        
        view.addSubview(workingTitleLabel)
        workingTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            workingTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            workingTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }
    
    func configureHourLabel() {
        workingHourLabel = UILabel()
        workingHourLabel.font = UIFont.systemFont(ofSize: 13)
        workingHourLabel.text = "09:00 - 15:00"
        
        view.addSubview(workingHourLabel)
        workingHourLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            workingHourLabel.topAnchor.constraint(equalTo: workingTitleLabel.bottomAnchor, constant: 4),
            workingHourLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }
    
    func configureWorkingDetailView() {
        
        workingDetailView = UIView()
        workingDetailView.backgroundColor = .systemGray5
        view.addSubview(workingDetailView)
        workingDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        workingDetailView.addSubview(workingHourLabel)
        workingDetailView.addSubview(workingTitleLabel)
        
        workingDetailView.layer.cornerRadius = 8
        
        NSLayoutConstraint.activate([
            workingDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13),
            workingDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            workingDetailView.heightAnchor.constraint(equalTo: workingHourLabel.heightAnchor, multiplier: 2.55),
            workingDetailView.widthAnchor.constraint(equalTo: workingHourLabel.widthAnchor, multiplier: 1.27)
        ])
    }
    
    func configureSegmentedController() {
        segmentedController = UISegmentedControl(items: ["Ana Yemekler","Tatlılar","İçecekler"])
        self.view.addSubview(segmentedController)
        segmentedController.translatesAutoresizingMaskIntoConstraints = false
        segmentedController.selectedSegmentIndex = 0
        
        segmentedController.addTarget(self, action: #selector(changedSegmentedControl), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            segmentedController.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            segmentedController.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            segmentedController.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
        ])
    }
    
    @objc private func changedSegmentedControl() {
        switch segmentedController.selectedSegmentIndex {
        case 0:
            print("Ana yemekleri getir")
            showingList.removeAll()
            showingList = foods
            tableView.reloadData()
        case 1:
            print("Tatlıları getir")
            showingList.removeAll()
            showingList = desserts
            tableView.reloadData()
        case 2:
            showingList.removeAll()
            showingList = drinks
            tableView.reloadData()
        default:
            fatalError("Hataaa")
        }
    }
}

extension MainPageVC: MainPageViewModelProtocol {
    
    func setTitle(dateString: String) {
        dateTitleLabel.text = dateString
        dateTitleLabel.font = .systemFont(ofSize: 25)
    }
}

extension MainPageVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showingList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else {
            fatalError("Could not dequeue cell with identifier: \(MainTableViewCell.identifier)")
        }

        cell.set(with: Dessert(name: showingList[indexPath.row], price: "12", image: "", isSold: false))
        return cell
    }
    
    //    MARK: Cell Edit
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //    MARK: Leading Swipe Action
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let foodEnding = UIContextualAction(style: .normal, title: Constant.soldText) { action, view, bool in
            print("Ürün tükendi")
        }
        
        foodEnding.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [foodEnding])
    }
    
    //    MARK: Trailing Swipe Action
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // TODO: Admin Check
        let edit = UIContextualAction(style: .normal, title: Constant.editText) { action, view, bool in
            self.showEditAlertView()
        }
        
        edit.backgroundColor = .systemOrange
        
        return UISwipeActionsConfiguration(actions: [edit])
    }
    
    //    MARK: - Alert View
    private func showEditAlertView() {
        
        let alertAction = UIAlertController(title: "Düzenle", message: "Gerekli bilgileri giriniz", preferredStyle: .alert)
        alertAction.addTextField { text in
            text.placeholder = "Ücreti yazınız"
        }
        
        
        let save = UIAlertAction(title: Constant.save, style: .default) { action in
            if let textfield = alertAction.textFields?.first {
                if let text = textfield.text {
                    print("View Modelden DB gönder verileri")
                    DispatchQueue.main.async {
                        // table view reload et
                    }
                }
            }
        }
        
        
        let cancel = UIAlertAction(title: Constant.cancel, style: .cancel)
        
        alertAction.addAction(save)
        alertAction.addAction(cancel)
        
        self.present(alertAction, animated: true)
        
    }
    
    //    MARK: - TableView Height Layout
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
