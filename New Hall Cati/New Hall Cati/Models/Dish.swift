//
//  Dish.swift
//  New Hall Cati
//
//  Created by furkan vural on 29.12.2023.
//

import UIKit

struct Dish: Hashable, Identifiable, Codable {
    
    let id = UUID()
    let name: String
    let price: String
    let image: String
    
    
    
}
