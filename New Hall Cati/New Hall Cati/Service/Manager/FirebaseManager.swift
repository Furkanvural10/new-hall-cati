import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol FirebaseManagerProtocol {
    func createAnonymousUser(completion: @escaping ((Result<User, NetworkError>) -> Void))
    func getData<T: Codable>(child: String, completion: @escaping ((Result<[T], NetworkError>) -> Void))
}


final class FirebaseManager: FirebaseManagerProtocol {
    
    static let shared = FirebaseManager()
    
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
        
        let database = Firestore.firestore()
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
                catch {
                    print("decode error")
                    completion(.failure(.decodeError))
                    return
                }
            }
            completion(.success(products))
        }
    }
}
