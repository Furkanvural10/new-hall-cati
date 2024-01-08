import UIKit

protocol AdminPageProtocol {
    
    var allFoodList: [String] { get }
    var allDessertList: [String] { get }
    var allDrinkList: [String] { get }
    var viewModel: AdminPageViewModel { get }
    var selectedMenu: Set<String> { get }
    var showingList: [String] { get }
    var items: [String] { get }
    
    func configureSegmentedController()
    func configureTableView()
    func configureNavigationSaveButton()
    func configureAddButton()
}

final class AdminPageVC: UIViewController, AdminPageProtocol {
    
    
    lazy var allFoodList = [String]()
    lazy var allDessertList = [String]()
    lazy var allDrinkList = [String]()
    var viewModel = AdminPageViewModel()

//    MARK: - UI Elements
    private var segmentedController = UISegmentedControl(frame: .zero)
    private var tableView: UITableView!
    private var addButton: UIButton!
    
//    MARK: - Mock Data
    var food = ["1F", "2F", "3F", "4F","5F", "6F", "7F", "8F","9F", "10F", "11F", "12F",]
    var dessert = ["1D", "2D", "3D", "4D"]
    var drink = ["1Dr", "2Dr", "3Dr", "4Dr"]
    var items: [String] = Constant.segmentedItems
    
    var selectedMenu: Set<String> = []
    var showingList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSegmentedController()
        showingList = food
        view.backgroundColor = .systemBackground
        
        configureTableView()
        configureNavigationSaveButton()
        configureAddButton()
        
        
    }
    
     func configureSegmentedController() {

         
         segmentedController = UISegmentedControl(items: items)
         segmentedController.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(segmentedController)
         segmentedController.selectedSegmentIndex = 0
         segmentedController.translatesAutoresizingMaskIntoConstraints = false
         segmentedController.addTarget(self, action: #selector(changedSegmentedControl), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            segmentedController.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            segmentedController.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            segmentedController.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)
        ])
    }
    
    @objc func changedSegmentedControl() {
        switch segmentedController.selectedSegmentIndex {
        case 0:
            showingList.removeAll()
            showingList = food
            tableView.reloadData()
        case 1:
            showingList.removeAll()
            showingList = dessert
            tableView.reloadData()
        case 2:
            showingList.removeAll()
            showingList = drink
            tableView.reloadData()
        default:
            fatalError("Fatal error")
        }
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
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80)
        ])
    }
    
    func configureNavigationSaveButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNewMenu))
    }
    
    @objc func saveNewMenu() {
        
    }
    
    func configureAddButton() {
        addButton = UIButton()
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        addButton.setTitle("Yeni Ürün Ekle", for: .normal)
        addButton.backgroundColor = .black.withAlphaComponent(0.9)
        addButton.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 5),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.045)
        ])
    }
}

extension AdminPageVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellView.identifier, for: indexPath) as? CellView else {
            fatalError("Could not dequeue cell with identifier: \(CellView.identifier)")
        }

        cell.set(with: showingList[indexPath.row])
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
            }
        } else {
            cell?.accessoryType = .checkmark
            selectedMenu.insert(showingList[indexPath.row])
        }
    }
}
