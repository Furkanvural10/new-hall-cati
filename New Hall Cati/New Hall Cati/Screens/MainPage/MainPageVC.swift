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

}


import Foundation

final class MainPageVC: UIViewController, MainPageViewModelProtocol {

    let mockData: [Dish] =
    [
        Dish(name: "Pilav", price: "12₺", image: UIImage(named: "menu-placeholder")!, isSold: false),
        Dish(name: "Makarna", price: "22₺", image: UIImage(named: "menu-placeholder")!, isSold: false),
        Dish(name: "Patlıcan Yemeği", price: "32₺", image: UIImage(named: "menu-placeholder")!, isSold: false),
        Dish(name: "Tavuk Sote Tavuk Sote", price: "42₺", image: UIImage(named: "menu-placeholder")!, isSold: false),
        Dish(name: "Et Sote", price: "52₺", image: UIImage(named: "menu-placeholder")!, isSold: false),
        Dish(name: "Patates Kızartması", price: "62₺", image: UIImage(named: "menu-placeholder")!, isSold: false),
        Dish(name: "Su Böreği", price: "42₺", image: UIImage(named: "menu-placeholder")!, isSold: false),
        Dish(name: "Kereviz", price: "52₺", image: UIImage(named: "menu-placeholder")!, isSold: false),
        Dish(name: "Domates Çorbası", price: "62₺", image: UIImage(named: "menu-placeholder")!, isSold: false),
        Dish(name: "Un Çorbası", price: "62₺", image: UIImage(named: "menu-placeholder")!, isSold: false),
        Dish(name: "Bezelye", price: "62₺", image: UIImage(named: "menu-placeholder")!, isSold: false),
        
        
    ]
    
    enum Section {
        case main
    }
    
    private enum ProductType: String, CaseIterable {
        case dish = "Ana Yemek"
        case drink = "Tatlılar"
        case dessert = "İçecekler"
    }
    private var productTitleList: [ProductType] = [.dish, .drink, .dessert]
    
    private var dateTitleLabel: UILabel!
    private var workingTitleLabel: UILabel!
    private var workingHourLabel: UILabel!
    private var workingDetailView: UIView!
    private var segmentedController: UISegmentedControl!
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Dish>!
    
    var viewModel = MainPageViewModel()
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.delegate = self
        configureTitle()
        
        configureWorkingLabel()
        configureHourLabel()
        configureSegmentedController()
        configureViewCollectionView()
        configureDataSource()
        configureDateTitle()
        self.updateData()
        
    }
    
    func configureViewCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.register(DishCell.self, forCellWithReuseIdentifier: DishCell.reusedID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: segmentedController.bottomAnchor, constant: 8),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
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
    
    func configureSegmentedController() {
        segmentedController = UISegmentedControl(items: Constant.segmentedItems)
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
            print("Main Dish Data")
        case 1:
            print("Dessert Data")
        case 2:
            print("Drink Data")
        default:
            fatalError("Fatal Error")
        }
    }
    
    func setTitle(dateString: String) {
        print("Tetiklendi")
        dateTitleLabel.text = dateString
        dateTitleLabel.font = .systemFont(ofSize: 25)
        dateTitleLabel.textColor = .black
    }
    
    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 65)
        
        return flowLayout
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Dish>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishCell.reusedID, for: indexPath) as! DishCell
            cell.set(dish: self.mockData[indexPath.row])
            return cell
        })
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Dish>()
        snapshot.appendSections([.main])
        snapshot.appendItems(mockData)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }
}
