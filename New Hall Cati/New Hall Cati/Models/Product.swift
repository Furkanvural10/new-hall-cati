import UIKit


// This struct represent all food. Ex. (Main Dish, Dessert, Drink, Snack)
struct Product: Hashable, Codable {
    var prodID: String
    var name: String
    var price: String
    var image: String
}
