import UIKit


struct Dessert {
    
    let name: String
    let price: String
    let image: String
    let isSold: Bool
}

struct Product: Codable, Identifiable {
    var id = UUID()
    var name: String
    var price: String
    var imageURL: String
}
