//
//  Order.swift
//  Yummie
//
//  Created by Haytham on 06/11/2023.
//

import Foundation

struct Order: Codable {
    let id: String?
    let name: String?
    let dish: Dish?
}
