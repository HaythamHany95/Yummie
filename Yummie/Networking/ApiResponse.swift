//
//  ApiResponse.swift
//  Yummie
//
//  Created by Haytham on 08/11/2023.
//

import Foundation

struct ApiResponse<T: Codable>: Codable {
    let status: Int
    let message: String?
    let data: T?
    let error: String?
}
