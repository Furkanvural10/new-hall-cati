import UIKit
import FirebaseFirestore
import Foundation
import AVFoundation



protocol MainPageProtocol {
    
    func configureBackground()
    func configureNavigationBar()
    func configureDateTitle()
    func configureVideoPlayer(videoURL: String?)
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
        case dish = "AllMainDish"
        case allDessert = "AllDessert"
        case snack = "AllSnack"
    }
    
    // MARK: - Properties
    var dailyMainDish: [Product] = []
    var dailyDessert: [Product] = []
    var dailySnack: [Product] = []
    var allColdDrink: [Product] = []
    var allHotDrink: [Product] = []
    var showingData: Array<Product>!
    var viewModel = MainPageViewModel()
    var player: AVPlayer?
    var playerLooper: AVPlayerLooper!
    var queuePlayer: AVQueuePlayer!
    
    private var productTitleList: ProductType = .dish
    
    // MARK: - UI Elements
    private var dateTitleLabel: UILabel!
    private var dateTitleView: UIView!
    private var segmentedController: UISegmentedControl!
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Product>!
    private var blurView: UIVisualEffectView!
    private var playerLayer: AVPlayerLayer!
    private var videoContainerView: UIView!
    private var videoTitleView: UIView!
    private var videoTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showingData = [Product]()
        viewModel.delegate = self
        getDataFromFirestore()
        configureDateTitle()
        configureBackground()
        configureNavigationBar()
        configureVideoPlayer()
        configureSegmentedController()
        configureCollectionView()
        configureDataSource()
        checkRestaurantStatus()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.queuePlayer.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.queuePlayer.pause()
    }
    
    deinit {
        print("MainPageVC deinit")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = videoContainerView.bounds
    }
    
    func getDataFromFirestore() {
        viewModel.getDailyMainDish()
        viewModel.getDailyDessert()
        viewModel.getAllColdDrink()
        viewModel.getAllHotDrink()
        viewModel.getAllSnack()
        viewModel.getDailyVideoURL()
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
        dateTitleLabel.font = .systemFont(ofSize: 20)
        
        dateTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateTitleLabel)
        
        NSLayoutConstraint.activate([
            dateTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            dateTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            dateTitleLabel.heightAnchor.constraint(equalToConstant: 31),
            dateTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -24)
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
        
        collectionView.delegate = self
        
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: segmentedController.bottomAnchor, constant: 1),
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
            segmentedController.topAnchor.constraint(equalTo: videoContainerView.bottomAnchor, constant: 28),
            segmentedController.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            segmentedController.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
    }
    
    @objc private func changedSegmentedControl() {
        switch segmentedController.selectedSegmentIndex {
        case 0:
            showingData = dailyMainDish
            productTitleList = .dish
            self.updateData()
        case 1:
            showingData = dailySnack
            productTitleList = .snack
            self.updateData()
        case 2:
            showingData = dailyDessert
            productTitleList = .allDessert
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
    
    func configureVideoPlayer(videoURL: String? = nil) {
        
        if let videoURL {
            let asset = AVAsset(url: URL(string: videoURL)!)
            queuePlayer = AVQueuePlayer()
            let playerItem = AVPlayerItem(asset: asset)
            self.queuePlayer = AVQueuePlayer(playerItem: playerItem)
            
            self.playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)
            self.playerLayer = AVPlayerLayer(player: queuePlayer)
            self.playerLayer.videoGravity = .resizeAspectFill
        } else {
            queuePlayer = AVQueuePlayer()
            playerLayer = AVPlayerLayer(player: queuePlayer)
            playerLayer.videoGravity = .resizeAspectFill
        }
        
        videoContainerView = UIView()
        videoContainerView.layer.cornerRadius = 10
        videoContainerView.clipsToBounds = true
        
        videoContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(videoContainerView)
        
        NSLayoutConstraint.activate([
            videoContainerView.topAnchor.constraint(equalTo: dateTitleLabel.bottomAnchor, constant: 10),
            videoContainerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            videoContainerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            videoContainerView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        if let playerLayer = playerLayer {
            videoContainerView.layer.addSublayer(playerLayer)
            playerLayer.frame = videoContainerView.bounds
        }
        
        videoContainerView.layoutIfNeeded()
        self.queuePlayer.play()
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
        dateTitleLabel.font = .systemFont(ofSize: 20)
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
    
    func getDailyVideoURL(videoURL: String) {
        configureVideoPlayer(videoURL: videoURL)
    }
}


extension MainPageVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedItem = showingData[indexPath.row]
        
        let action1 = UIAlertAction(title: "Daha fazla olmalı 🔥", style: .default) { [self] action in
            FirebaseManager.shared.postProductionFeedback(
                product: selectedItem,
                selectedProduct: productTitleList.rawValue,
                prodID: selectedItem.prodID,
                isLiked: true
            )
        }
        
        let action2 = UIAlertAction(title: "Tercih etmiyorum 👎", style: .destructive) { [self] action in
            FirebaseManager.shared.postProductionFeedback(
                product: selectedItem,
                selectedProduct: productTitleList.rawValue,
                prodID: selectedItem.prodID,
                isLiked: false
            )
        }
        
        let alertController = UIAlertController(title: "Düşünceniz Önemli", message: "\(selectedItem.name) için fikrinizi belirtebilirsiniz", preferredStyle: .actionSheet)
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(UIAlertAction(title: "İptal", style: .cancel, handler: nil))
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = collectionView.cellForItem(at: indexPath)
            popoverController.sourceRect = collectionView.cellForItem(at: indexPath)?.bounds ?? CGRect.zero
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
}
