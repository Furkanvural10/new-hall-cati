import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

protocol FirebaseManagerProtocol {
    func createAnonymousUser(completion: @escaping ((Result<User, NetworkError>) -> Void))
    func getData<T: Codable>(child: String, completion: @escaping ((Result<[T], NetworkError>) -> Void))
    func saveMenu(product: Product, selectedProduct: String)
    func saveRestaurantStatus(status: Bool)
    func getRestaurantStatus(completion: @escaping (Result<RestaurantStatus, Error>) -> Void)
    func deleteSelectedItem(productType: String, product: Product)
    func uploadVideo(videoName: String, videoData: Data, child: String, completion: @escaping (Result<String, Error>) -> Void)
}

final class FirebaseManager: FirebaseManagerProtocol {
    
    static let shared = FirebaseManager()
    private let database = Firestore.firestore()
    private let storage = Storage.storage()
    
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
        
        let newData = [
            "name" : product.name,
            "price" : product.price,
            "image": product.image,
            "prodID" : product.prodID,
            "like" : product.like
        ] as [String : Any]
        
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        
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
    
    func addNewProduct(newProduct: Product, dishType: String, completion: @escaping (Error?) -> Void) {
        
        let id = UUID().uuidString
        
        let data = [
            "id" : id,
            "prodID" : id,
            "price" : newProduct.price,
            "name" : newProduct.name,
            "image" : newProduct.image,
            "like" : newProduct.like,
        ] as [String : Any]
        
        
        database.collection(dishType).document(id).setData(data) { error in
            guard error == nil else { return }
            completion(nil)
        }
    }
    
    func uploadImage(imageName: String, imageData: Data, child: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        let storageRef = storage.reference()
        let mediaFolder = storageRef.child(child)
        let id = UUID().uuidString
        let imageReference = mediaFolder.child("\(imageName)\(id.prefix(3)).jpg")
        
        let uploadTask = imageReference.putData(imageData, metadata: nil) { metaData, error in
            if error != nil {
                completion(.failure(error!))
            } else {
                imageReference.downloadURL { url, error in
                    if error == nil {
                        let imageUrl = url?.absoluteString
                        completion(.success(imageUrl!))
                    } else {
                        completion(.failure(error!))
                    }
                }
            }
        }
        
        uploadTask.observe(.progress) { snapshot in
            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
            print("Yükleme yüzdesi: \(percentComplete)%")
        }
        
        uploadTask.observe(.success) { snapshot in
            print("Yükleme başarıyla tamamlandı. ✅")
        }
    }
    
    
    func saveRestaurantStatus(status: Bool) {
        let newData = [ "status" : status ]
        database.collection("Status").document("RestaurantStatus").setData(newData) { error in
            guard error == nil else { return }
        }
    }
    
    func getRestaurantStatus(completion: @escaping (Result<RestaurantStatus, Error>) -> Void) {
        
        database.collection("Status").document("RestaurantStatus").addSnapshotListener { snapshot, error in
            
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard let snapshot = snapshot else {
                let error = NSError(domain: "Error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to get snapshot"])
                completion(.failure(error))
                return
            }
            
            
            if let status = snapshot["status"] as? Bool {
                let restaurantModel = RestaurantStatus(status: status)
                completion(.success(restaurantModel))
                return
            }
            else {
                let error = NSError(domain: "Error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to get status"])
                completion(.failure(error))
            }
            
        }
    }
    
    func deleteSelectedItem(productType: String, product: Product) {
        
        database.collection(productType).document(product.prodID).delete { error in
            guard error != nil else {
                return
            }
        }
    }
    
    
    func postProductionFeedback(product: Product, selectedProduct: String, prodID: String, isLiked: Bool) {
        database.collection(selectedProduct).document(prodID).updateData([
            "like" : isLiked ? product.like + 1 : product.like
        ])
    }
    
    func getAllFavoriteProduct(selectedProduct: String) {
        
        // Collectionlar'da Enum raw valueden gelebilir daha sağlıklı olur.
        database.collection("FavoriteProduct").getDocuments { snapshot, error in
            
        }
    }
    
    func uploadVideo(videoName: String, videoData: Data, child: String, completion: @escaping (Result<String, Error>) -> Void) {
        let storageRef = storage.reference()
        let mediaFolder = storageRef.child(child)
        let videoReference = mediaFolder.child("\(videoName).mp4")
        
        let uploadTask = videoReference.putData(videoData, metadata: nil) { metaData, error in
            if error != nil {
                completion(.failure(error!))
            } else {
                videoReference.downloadURL { url, error in
                    if error == nil {
                        let videoUrl = url?.absoluteString
                        self.uploadDailyVideoURL(url: videoUrl!)
                        completion(.success(videoUrl!))
                    } else {
                        completion(.failure(error!))
                    }
                }
            }
        }
        
        uploadTask.observe(.progress) { snapshot in
            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
            print("Yükleme yüzdesi: \(percentComplete)%")
        }
        
        uploadTask.observe(.success) { snapshot in
            print("Yükleme başarıyla tamamlandı. ✅")
        }
    }
    
    func uploadDailyVideoURL(url: String) {
        database.collection("DailyVideo").document("videoURL").setData(
            ["videoURL" : url]
        )
    }
    
    func getDailyVideoURL(completion: @escaping (String) -> Void) {
        
        database.collection("DailyVideo").document("videoURL").addSnapshotListener { snapshot, error in
            guard error == nil else {
                return
            }
            
            guard let snapshot = snapshot else {
                return
            }
            
            if let url = snapshot["videoURL"] as? String {
                completion(url)
            }
        }
    }
}
