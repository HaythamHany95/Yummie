//
//  String.swift
//  Yummie
//
//  Created by Haytham on 02/11/2023.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
