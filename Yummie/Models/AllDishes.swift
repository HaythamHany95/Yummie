//
//  AllDishes.swift
//  Yummie
//
//  Created by Haytham on 09/11/2023.
//

import Foundation

struct AllDishes: Codable {
    let categories: [DishCategory]?
    let populars: [Dish]?
    let specials: [Dish]?
}
