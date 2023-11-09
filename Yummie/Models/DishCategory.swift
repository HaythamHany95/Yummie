//
//  DishCategory.swift
//  Yummie
//
//  Created by Haytham on 02/11/2023.
//

import Foundation

struct DishCategory: Codable {
    let id: String?
    let name: String?
    let image: String?
    
    ///*To correct the key to be the same as the backend's response*
    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case image
    }
}

