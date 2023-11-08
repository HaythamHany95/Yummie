//
//  NetworkManager.swift
//  Yummie
//
//  Created by Haytham on 07/11/2023.
//

import Foundation

struct NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func sendFirstRequest(completion: @escaping (Result<[Dish], Error>) -> Void) {
        request(path: .temp, method: .get, completion: completion)
    }
    
    /// This function helps us to create urlRequest
    /// - Parameters:
    ///   - path: The path to the resources in the backend
    ///   - method: Type of request to be made
    ///   - parameters: Whatever extra information you need to pass to the backend
    /// - Returns: URLRequest
   
    //MARK: - 1. Generate URLRequest
    
    private func createRequest(path: Path, method: Method, parameters: [String: Any]? = nil) -> URLRequest? {
        
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
    
    //MARK: - 2. Make Request to the backend
    
    private func request<T: Codable>(path: Path, method: Method, parameters: [String: Any]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        
        ///Using instance from Generating Request function to make the request
        guard let request = createRequest(path: path, method: method, parameters: parameters) else {
            completion(.failure(AppError.requestError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: Result<Data, Error>?
            
            if let data = data {
                result = .success(data)
                /// *Convert data into string to check it in console (Not Nessessary)
                let responseString = String(data: data, encoding: .utf8) ?? "Couldn't stringify data"
                print("The response is: \(responseString)")
                
            } else if let error = error {
                result = .failure(error)
                print(error.localizedDescription)
            }
            
            ///Sending the result data that decoded to the user
            DispatchQueue.main.async {
                self.handleResponse(result: result, completion: completion)
            }
        }
        .resume()
    }
    
    //MARK: - 3. Decode Response
    
    private func handleResponse<T: Codable>(result: (Result<Data, Error>?), completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let result = result else {
            completion(.failure(AppError.noResult))
            return
        }
        
        switch result {
            
        case .success(let data):
            guard let response = try? JSONDecoder().decode(ApiResponse<T>.self, from: data) else {
                completion(.failure(AppError.errorDecoding))
                return
            }
            
            if let decodedError = response.error {
                completion(.failure(AppError.serverError(decodedError)))
                return
            }
            
            if let decodedData = response.data {
                completion(.success(decodedData))
                
            } else {
                completion(.failure(AppError.dataError))
            }
            
            
        case .failure(let error):
            completion(.failure(error))
        }
        
    }
    
}
