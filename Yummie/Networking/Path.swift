//
//  Route.swift
//  Yummie
//
//  Created by Haytham on 07/11/2023.
//

import Foundation

enum Path {
    static let baseUrl = "https://yummie.glitch.me"
    
    case FetchAllCategories
    case PlaceOrder(String)
    case FetchCategoryDishes(String)
    case FetchOrders
    
    var endPoint: String {
        switch self {
            
        case .FetchAllCategories:
            return "/dish-categories"
            
        case .PlaceOrder(let dishId):
            return "/orders/\(dishId)"
            
        case .FetchCategoryDishes(let categoryId):
            return "/dishes/\(categoryId)"
            
        case .FetchOrders:
            return "/orders"
        }
    }
}
