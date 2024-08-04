import UIKit
import FirebaseFirestore
import Foundation
#warning("Dont forget functions order")


protocol MainPageProtocol {
    
    func configureBackground()
    func configureNavigationBar()
    func configureDateTitle()
//    func configureWorkingLabel()
//    func configureHourLabel()
//    func configureWorkingDetailView()
    func configureCollectionView()
    func configureSegmentedController()
    func configureBlurView()
    func checkRestaurantStatus()
    
    var viewModel: MainPageViewModel { get }
    var isUserAdmin: Bool { get }
    var isBlurViewOn: Bool? { get }
}

final class MainPageVC: UIViewController {
    
    
    enum Section {
        case main
    }
    
    private enum ProductType: String, CaseIterable {
        case dish = "Ana Yemek"
        case drink = "Tatlılar"
        case dessert = "İçecekler"
    }
    
    // MARK: - Properties
    var dailyMainDish: [Product] = []
    var dailyDessert: [Product] = []
    var dailySnack: [Product] = []
    var allColdDrink: [Product] = []
    var allHotDrink: [Product] = []
    var showingData: Array<Product>!
    var viewModel = MainPageViewModel()
    private var productTitleList: [ProductType] = [.dish, .drink, .dessert]
    

    // MARK: - UI Elements
    private var dateTitleLabel: UILabel!
    private var segmentedController: UISegmentedControl!
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Product>!
    private var blurView: UIVisualEffectView!

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        showingData = [Product]()
        viewModel.delegate = self
        getDataFromFirestore()
        configureBackground()
        configureNavigationBar()
        configureSegmentedController()
        configureCollectionView()
        configureDataSource()
        configureDateTitle()
        checkRestaurantStatus()
    }
    
    func getDataFromFirestore() {
        viewModel.getDailyMainDish()
        viewModel.getDailyDessert()
        viewModel.getAllColdDrink()
        viewModel.getAllHotDrink()
        viewModel.getAllSnack()
    }

    private func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
     
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 45)
        
        return flowLayout
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Product>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishCell.reusedID, for: indexPath) as! DishCell
            cell.set(product: self.showingData[indexPath.row])
            return cell
        })
    }
    
    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Product>()
        snapshot.appendSections([.main])
        snapshot.appendItems(showingData)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }
    
    private func removeBlurView() {
        blurView?.removeFromSuperview()
        blurView = nil
    }
}

extension MainPageVC: MainPageProtocol {
    
    var isUserAdmin: Bool {
        UserDefaultsManager.shared.getUserTypeData()
    }
    
    var isBlurViewOn: Bool? {
        return nil
    }
    
    func checkRestaurantStatus() {
        viewModel.getRestaurantStatus()
    }
    
    func configureBlurView() {
        let blur = UIBlurEffect(style: .dark)
        blurView = UIVisualEffectView(effect: blur)
        
        blurView.frame = view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurView)
        
        let label = UILabel()
        label.text = "New Hall Çatı Kapalı 🔴"
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        blurView.contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: blurView.contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: blurView.contentView.centerYAnchor)
        ])
    }
    
    func configureBackground() {
        view.backgroundColor = .black
    }
    
    func configureDateTitle() {
        
        dateTitleLabel = UILabel()
        dateTitleLabel.textColor = .white
        
        view.addSubview(dateTitleLabel)
        dateTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            dateTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5)
        ])
        
        viewModel.setTitle()
    }

    
    @objc private func editWorkingHour() {
        presentDatePickerViewOnMainThread()
    }
    
    
    func configureNavigationBar() {
        
        let titleLabel = UILabel()
        titleLabel.text = Constant.welcomeText
        titleLabel.font = UIFont.pacificoRegular(size: 20)
        titleLabel.textColor = .white
        
        self.navigationItem.titleView = titleLabel
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Admin", style: .done, target: self, action: #selector(openAdminPage))
        self.navigationItem.rightBarButtonItem?.isHidden = !isUserAdmin
    }
    
    @objc private func openAdminPage() {
        self.navigationController?.pushViewController(AdminPageVC(), animated: true)
    }
    
    func configureCollectionView() {
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        collectionView.register(DishCell.self, forCellWithReuseIdentifier: DishCell.reusedID)
        collectionView.backgroundColor = .black
        
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: segmentedController.bottomAnchor, constant: 8),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func configureSegmentedController() {
        
        segmentedController = UISegmentedControl(items: Constant.segmentedItems)
        self.view.addSubview(segmentedController)
        segmentedController.translatesAutoresizingMaskIntoConstraints = false
        segmentedController.selectedSegmentIndex = 0
        segmentedController.selectedSegmentTintColor = .systemOrange
        
        let selectedAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        segmentedController.setTitleTextAttributes(selectedAttributes, for: .selected)
        
        let unselectedAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.9)]
        segmentedController.setTitleTextAttributes(unselectedAttributes, for: .normal)

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
            showingData = dailyMainDish
            self.updateData()
        case 1:
            showingData = dailySnack
            self.updateData()
        case 2:
            showingData = dailyDessert
            self.updateData()
        default:
            showDrinkOptionView()
            self.updateData()
        }
    }
    
    private func showDrinkOptionView() {
        
        let controller = UIAlertController(title: "İçecek Türü", message: "Görmek istediğiniz içecek türünü seçiniz.", preferredStyle: .actionSheet)
        
        let coldDrinkOption = UIAlertAction(title: "Soğuk", style: .default) { _ in
            self.showingData = self.allColdDrink
            self.updateData()
        }
        
        let hotDrinkOption = UIAlertAction(title: "Sıcak", style: .destructive) { _ in
            self.showingData = self.allHotDrink
            self.updateData()
        }
        
        let cancel = UIAlertAction(title: "İptal", style: .cancel) { _ in
            self.segmentedController.selectedSegmentIndex = 0
            self.showingData = self.dailyMainDish
            self.updateData()
        }
        
        controller.addAction(coldDrinkOption)
        controller.addAction(hotDrinkOption)
        controller.addAction(cancel)
        self.present(controller, animated: true)
    }
}


extension MainPageVC: MainPageViewModelProtocol {
    
    func updateRestaurantStatusIsOn() {
        configureBlurView()
    }
    
    func updateRestaurantStatusIsOff() {
        removeBlurView()
    }
    
    
    func setTitle(dateString: String) {
        dateTitleLabel.text = dateString
        dateTitleLabel.font = .systemFont(ofSize: 25)
        dateTitleLabel.textColor = .white
    }
    
    
    func getDailyMainDish(dish: [Product]) {
        dailyMainDish = dish
        self.showingData = dailyMainDish
        self.updateData()
    }
    
    func getDailyDessert(dessert: [Product]) {
        self.dailyDessert = dessert
    }
    
    func getColdDrink(coldDrink: [Product]) {
        self.allColdDrink = coldDrink
    }
    
    func getHotDrink(hotDrink: [Product]) {
        self.allHotDrink = hotDrink
    }
    
    func getDailySnack(snack: [Product]) {
        self.dailySnack = snack
    }
}


