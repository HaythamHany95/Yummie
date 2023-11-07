//
//  NetworkManager.swift
//  Yummie
//
//  Created by Haytham on 07/11/2023.
//

import Foundation

struct NetworkManager {
    
    /// This function helps us to create urlRequest
    /// - Parameters:
    ///   - path: The path to the resources in the backend
    ///   - method: Type of request to be made
    ///   - parameters: Whatever extra information you need to pass to the backend
    /// - Returns: URLRequest
    
     func createRequest(path: Path, method: Method, parameters: [String: Any]? = nil) -> URLRequest? {
        
        let urlString = Path.baseUrl + path.endPoint
        guard let url = URL(string: urlString) else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        
        if let params = parameters {
            switch method {
            case .get:
                var urlComponents = URLComponents(string: urlString)
                urlComponents?.queryItems = params.map { URLQueryItem(name: $0, value: "\($1)") }
                urlRequest.url = urlComponents?.url
                
            case .post, .patch, .delete:
                let dataBody = try? JSONSerialization.data(withJSONObject: params)
                urlRequest.httpBody = dataBody
                
            }
        }
        return urlRequest
    }
}
