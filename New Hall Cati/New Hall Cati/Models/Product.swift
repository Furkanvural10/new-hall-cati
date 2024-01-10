
import UIKit


struct Product: Hashable, Identifiable, Codable {
    let id = UUID()
    let name: String
    let price: String
    let image: String
}
