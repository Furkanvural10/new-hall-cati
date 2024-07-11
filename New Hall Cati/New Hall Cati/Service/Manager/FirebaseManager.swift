import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol FirebaseManagerProtocol {
    func createAnonymousUser(completion: @escaping ((Result<User, NetworkError>) -> Void))
    func getData<T: Codable>(child: String, completion: @escaping ((Result<[T], NetworkError>) -> Void))
    func saveMenu(product: Product, selectedProduct: String)
}

final class FirebaseManager: FirebaseManagerProtocol {
    
    static let shared = FirebaseManager()
    private let database = Firestore.firestore()
    
    
    private init() {}
    
    func createAnonymousUser(completion: @escaping (Result<User, NetworkError>) -> Void) {
        
        Auth.auth().signInAnonymously { result, error in
            guard error == nil else {
                completion(.failure(.authError))
                return
            }
            guard let result = result else {
                completion(.failure(.authResultError))
                return
            }
            
            let user = User(userID: result.user.uid)
            completion(.success(user))
        }
    }
    
    func getData<T: Codable>(child: String, completion: @escaping ((Result<[T], NetworkError>) -> Void)) {
        
        
        database.collection(child).addSnapshotListener { snapshot, error in
            guard error == nil else {
                print("Data error")
                completion(.failure(.dataError))
                return
            }
            
            guard let snapshot = snapshot else {
                print("Snapshot error")
                completion(.failure(.snapshotError))
                return
            }
            var products = [T]()
            for document in snapshot.documents {
                do {
                    let product = try document.data(as: T.self)
                    products.append(product)
                }
                
                catch let DecodingError.dataCorrupted(context) {
                    print(context)
                }catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
            }
            completion(.success(products))
        }
    }
    
    func updateProduct(product: Product, selectedProduct: String, newValue: Int, completion: @escaping ((Bool)) -> Void) {
        let updateData = [ "price" : "\(newValue) ₺" ]
        database.collection(selectedProduct).document(product.prodID).updateData(updateData) { error in
            guard error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func saveMenu(product: Product, selectedProduct: String) {
        
        
        
        let id = UUID().uuidString
        
        let newData = [
            "name" : product.name,
            "price" : product.price,
            "image": product.image,
            "prodID" : product.prodID
        ]
        
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let todayString = dateFormatter.string(from: today)
        
        var dishType = ""
        
        switch selectedProduct {
        case "AllMainDish":
            dishType = "DailyMainDish"
        case "AllDessert":
            dishType = "DailyDessert"
        case "AllSnack":
            dishType = "DailySnack"
        default:
            break
        }
        
        database.collection(dishType).document(product.prodID).setData(newData) { error in
            guard error == nil else { return }
            
            
        }
    }
    
    
    
    
    func deleteAllDocuments(selectedProduct: String, batchSize: Int = 50, completion: @escaping (Error?) -> Void) {
        
        
        var dishType = ""
        
        switch selectedProduct {
        case "AllMainDish":
            dishType = "DailyMainDish"
        case "AllDessert":
            dishType = "DailyDessert"
        case "AllSnack":
            dishType = "DailySnack"
        default:
            break
        }
        
        let collectionRef = database.collection(dishType)
        
        collectionRef.limit(to: batchSize).getDocuments { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                completion(error)
                return
            }
            
//            guard !documents.isEmpty else {
//                completion(nil)
//                return
//            }
            
            let batch = collectionRef.firestore.batch()
            
            documents.forEach { batch.deleteDocument($0.reference) }
            
            batch.commit { batchError in
                if let batchError = batchError {
                    completion(batchError)
                }
            }
        }
    }
    
    func loginAdmin(adminPassword: String, completion: @escaping (Bool) -> Void) {
        
        database.collection("Admin").document("Access").getDocument { snapshot, error in
            guard error == nil else {
                completion(false)
                return
            }
            
            guard let snapshot = snapshot else {
                completion(false)
                return
            }
            
            if let data = snapshot["id"] as? String {
                switch data {
                case adminPassword:
                    completion(true)
                default:
                    completion(false)
                }
            }
            return
        }
    }
}
