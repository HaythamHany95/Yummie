//
//  AppError.swift
//  Yummie
//
//  Created by Haytham on 08/11/2023.
//

import Foundation

enum AppError: LocalizedError {
    
    case invalidUrl
    case requestError
    case noResult
    case resultError
    case dataError
    case errorDecoding
    case errorEncoding
    case serverError(String)
    case unknownError

    
    var errorDescription: String? {
        switch self {
       
        case .invalidUrl:
            return "Give me a valid Url"
            
        case .requestError:
            return "Request Failed"
            
        case .noResult:
            return "Actually we got no result"
            
        case .resultError:
            return "Result Error"
            
        case .dataError:
            return "No data found"
            
        case .errorDecoding:
            return "Response couldn't be decoded"
            
        case .errorEncoding:
            return "Couldn't encoding"
        
        case .serverError(let error):
            return error
            
        case .unknownError:
            return "Bruhhhh!!! Unknown Error"
        }
    }
}
