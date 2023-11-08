//
//  Route.swift
//  Yummie
//
//  Created by Haytham on 07/11/2023.
//

import Foundation

enum Path {
    static let baseUrl = "https://yummie.glitch.me"
    
    case temp
    
    var endPoint: String {
        switch self {
        case .temp:
            return "/dishes/cat1"
        }
    }
}
