import UIKit

protocol AdminPageProtocol {
    
    var allFoodList: [String] { get }
    var allDessertList: [String] { get }
    var allDrinkList: [String] { get }
    var viewModel: AdminPageViewModel { get }
    
    func configureSegmentedController()
    func configureTableView()
    func configureNavigationSaveButton()
}

final class AdminPageVC: UIViewController, AdminPageProtocol {
    
    
    lazy var allFoodList = [String]()
    lazy var allDessertList = [String]()
    lazy var allDrinkList = [String]()
    var viewModel = AdminPageViewModel()

//    MARK: - UI Elements
    private var segmentedController: CustomSegmentedController!
    private var tableView: UITableView!
    
//    MARK: - Mock Data
    var food = ["1F", "2F", "3F", "4F"]
    var dessert = ["1D", "2D", "3D", "4D"]
    var drink = ["1Dr", "2Dr", "3Dr", "4Dr"]
    
    var selectedMenu: Set<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureSegmentedController()
        configureTableView()
        configureNavigationSaveButton()
        
        
    }
    
     func configureSegmentedController() {
        segmentedController = CustomSegmentedController(frame: .zero)
        let items = ["Ana Yemek", "Tatlılar", "İçecekler"]
        segmentedController.setItems(items, startingIndex: 0)
        
        view.addSubview(segmentedController)
        
        NSLayoutConstraint.activate([
            segmentedController.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            segmentedController.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            segmentedController.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)
        ])
    }
    
    func configureTableView() {
        tableView = UITableView()
        tableView.register(CellView.self, forCellReuseIdentifier: CellView.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentedController.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
    func configureNavigationSaveButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNewMenu))
    }
    
    @objc func saveNewMenu() {
        print("Save new menu item \(selectedMenu)")
    }
}

extension AdminPageVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return food.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellView.identifier, for: indexPath) as? CellView else {
            fatalError("Could not dequeue cell with identifier: \(CellView.identifier)")
        }

        cell.set(with: food[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let cell = tableView.cellForRow(at: indexPath)
        let selectedItem = food[indexPath.row]
        
        if cell?.accessoryType == .checkmark {
            cell?.accessoryType = .none
            if selectedMenu.contains(selectedItem) {
                selectedMenu.remove(selectedItem)
                print(selectedMenu)
            }
            
        } else {
            cell?.accessoryType = .checkmark
            print(food[indexPath.row])
            selectedMenu.insert(food[indexPath.row])
            print(selectedMenu)
        }
        
    }
}
