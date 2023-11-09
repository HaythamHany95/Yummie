//
//  PopularDish.swift
//  Yummie
//
//  Created by Haytham on 02/11/2023.
//

import Foundation

struct Dish: Codable {
    let id: String?
    let name: String?
    let image: String?
    let calories: Int?
    let descreption: String?
    
    ///*To correct the key to be the same as the backend's response*
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case calories
        case descreption = "description"
    }
}
