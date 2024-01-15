import UIKit

protocol AdminPageProtocol: AnyObject {
    
    var selectedMenu: Set<Product> { get }
    var showingList: [Product] { get }
    var items: [String] { get }
    
    func configureSegmentedController()
    func configureTableView()
    func configureNavigationSaveButton()
    func configureAddButton()
    func fetchDish(product: [Product])
}

final class AdminPageVC: UIViewController, AdminPageProtocol {
    
    
    private var viewModel = AdminPageViewModel()

//    MARK: - UI Elements
    private var segmentedController = UISegmentedControl(frame: .zero)
    private var tableView: UITableView!
    private var addButton: UIButton!
        
    var items: [String] = Constant.segmentedItems
    
    var selectedMenu: Set<Product> = []
    var showingList: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
        getDataFromFirestore()
        configureSegmentedController()
        view.backgroundColor = .systemBackground
        
        configureTableView()
        configureNavigationSaveButton()
        configureAddButton()
        
        
    }
    
    func getDataFromFirestore() {
        viewModel.getAllMainDish()
        viewModel.getAllDessert()
        viewModel.getAllDrink()
        viewModel.getAllSnack()
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
        showingList.removeAll()
        switch segmentedController.selectedSegmentIndex {
        case 0:
            showingList = viewModel.allMainDish
            tableView.reloadData()
        case 1:
            
            showingList = viewModel.allSnack
            tableView.reloadData()
        case 2:
            
            showingList = viewModel.allDessert
            tableView.reloadData()
        default:
            
            showingList = viewModel.allDrink
            tableView.reloadData()
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
    
    func fetchDish(product: [Product]) {
        showingList = product
        tableView.reloadData()
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

//        let cell = tableView.cellForRow(at: indexPath)
//        let selectedItem = food[indexPath.row]
//        
//        if cell?.accessoryType == .checkmark {
//            cell?.accessoryType = .none
//            if selectedMenu.contains(selectedItem) {
//                selectedMenu.remove(selectedItem)
//            }
//        } else {
//            cell?.accessoryType = .checkmark
//            selectedMenu.insert(showingList[indexPath.row])
//            
//        }
    }
}
