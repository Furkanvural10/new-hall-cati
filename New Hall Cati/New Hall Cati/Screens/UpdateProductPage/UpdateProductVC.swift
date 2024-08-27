//
//  UpdateProductVC.swift
//  New Hall Cati
//
//  Created by furkan vural on 16.05.2024.
//

import UIKit

final class UpdateProductVC: UIViewController {
    
    private var tableView: UITableView!
    private var barButton: UIBarButtonItem!
    private var addNewProductButton: UIButton!
    private var uploadingProcessView: UIActivityIndicatorView!
    
    private var showingList: [Product] = []
    private var productSavedList: Set<Product> = []
    private var viewModel = AdminPageViewModel()
    var selectedProduct: String?
    lazy var newValue: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        viewModel.delegate = self
        configureRightBarButtonItem()
        configureAddNewProductButton()
        getProduct()
        configureTableView()
        configureUploadingProcess()
    }
    
    private func configureRightBarButtonItem() {
        if selectedProduct != "AllDrink" && selectedProduct != "AllHotDrink" {
            barButton = UIBarButtonItem(title: "Kaydet", style: .plain, target: self, action: #selector(clickedRightBarButton))
            barButton.isEnabled = false
            self.navigationItem.rightBarButtonItem = barButton
        }
        
    }
    
    private func configureTableView() {
        tableView = UITableView()
        tableView.register(CellView.self, forCellReuseIdentifier: CellView.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: addNewProductButton.topAnchor, constant: -10)
        ])
    }
    
    func configureAddNewProductButton() {
        
        addNewProductButton = UIButton()
        addNewProductButton.setTitle("+ Yeni Ürün Ekle", for: .normal)
        addNewProductButton.layer.cornerRadius = 10
        addNewProductButton.backgroundColor = .systemGreen
        
        view.addSubview(addNewProductButton)
        addNewProductButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addNewProductButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addNewProductButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addNewProductButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addNewProductButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06),
            addNewProductButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        
        addNewProductButton.addTarget(self, action: #selector(sendNewProductVC), for: .touchUpInside)
        
    }
    
    @objc private func sendNewProductVC() {
        let destinationVC = NewProductViewController()
        destinationVC.dishType = selectedProduct
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    private func getProduct() {
        guard let selectedProduct else { return }
        viewModel.getAllMainDish(product: selectedProduct)
    }
    
    @objc private func clickedRightBarButton() {
        view.isUserInteractionEnabled = false
        uploadingProcessView.startAnimating()
        viewModel.saveNewMenu(productList: productSavedList, selectedProduct: selectedProduct!)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            self.uploadingProcessView.stopAnimating()
            self.showMessage()
            
        }
    }
    
    private func showMessage() {
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Başarılı 👋", message: "İşlem başarıyla tamamlandı 😊", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Tamam", style: .default) { _ in
                self.navigationController?.popViewController(animated: true)
            }
            alertController.addAction(okButton)
            
            self.present(alertController, animated: true)
        }
    }
    
    private func configureUploadingProcess() {
        
        uploadingProcessView = UIActivityIndicatorView()
        uploadingProcessView.style = .large
        
        view.addSubview(uploadingProcessView)
        uploadingProcessView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            uploadingProcessView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uploadingProcessView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
}



extension UpdateProductVC: UITableViewDelegate, UITableViewDataSource {
    
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
        
            let item = showingList[indexPath.row]
            cell.set(with: item)
            
            
            if productSavedList.contains(item) {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if selectedProduct == "AllDrink" || selectedProduct == "AllHotDrink" {
            return
        }
        
        let cell = tableView.cellForRow(at: indexPath)
        
        let selectedItem = showingList[indexPath.row]
        
        if cell?.accessoryType == .checkmark {
            cell?.accessoryType = .none
            productSavedList.remove(selectedItem)
            
        } else {
            cell?.accessoryType = .checkmark
            print("Index: \(indexPath.row)")
            
            productSavedList.insert(selectedItem)
            
        }
        
        barButton.isEnabled = productSavedList.count > 0 ? true: false
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let update = UIContextualAction(style: .normal, title: "Güncelle") { (action, view, success) in
            view.backgroundColor = .systemOrange
            print("Güncellenecek eleman: \(self.showingList[indexPath.row].name)")
            self.showAlertMessage(product: self.showingList[indexPath.row])
        }
        
        
        
        let swipeActions = UISwipeActionsConfiguration(actions: [update])
        return swipeActions
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Sil") { action, view, success in
            action.backgroundColor = .red
            view.isUserInteractionEnabled = false
            
            DispatchQueue.main.async {
                self.uploadingProcessView.startAnimating()
                
            }
            

            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.viewModel.deleteSelectedFood(productType: self.selectedProduct!, product: self.showingList[indexPath.row])
                self.uploadingProcessView.stopAnimating()
            }
            
            
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [delete])
        return swipeActions
    }
    
    private func showAlertMessage(product: Product) {
        
        
        let alertMessage = UIAlertController(title: "Ürün güncelle", message: nil, preferredStyle: .alert)
        alertMessage.addTextField { textField in
            textField.keyboardType = .numberPad
            textField.placeholder = "\(product.name) (₺)"
            textField.delegate = self
        }
        
        let cancelButton = UIAlertAction(title: "İptal", style: .destructive)
        let saveButton = UIAlertAction(title: "Kaydet", style: .default) { _ in
            self.viewModel.updateProduct(product: product, selectedProduct: self.selectedProduct!, newValue: Int(self.newValue)! )
        }
        
        alertMessage.addAction(cancelButton)
        alertMessage.addAction(saveButton)
        self.present(alertMessage, animated: true)
    }

}

extension UpdateProductVC: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        newValue = textField.text!
    }
}

extension UpdateProductVC: AdminPageProtocol {
    func didUpdateSuccessfully() {
        showMessage()
    }
    
    func fetchDish(product: [Product]) {
        showingList = product
        tableView.reloadData()
    }
}



