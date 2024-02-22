//
//  APIManager.swift
//  SwiftExample
//
//  Created by 200OK-IOS5 on 15/02/24.
//

import Foundation

/// Type alias for a completion handler with a `Result` type.
typealias completionHandler<T> =  (Result<T, ApiError>) -> Void

/// Type alias for a parameter dictionary.
typealias Parameter = [String: Any]

/// Protocol defining the structure of an API manager.
protocol APIManagerProtocol {
    /// Performs a network request using the specified API configuration.
    ///
    /// - Parameters:
    ///   - apiConfig: The API configuration specifying the request details.
    ///   - resultBlock: The completion handler called when the request is complete.
    func request<T: Decodable>(useConfig apiConfig: APIConfig,
                               resultBlock: @escaping completionHandler<T>)
    
    /// Encodes parameters into a format suitable for a request body.
    ///
    /// - Parameter params: The parameters to be encoded.
    /// - Returns: The encoded data representing the parameters.
    func encodeParameter(params: [String: Any]) -> Data?
}

/// Class implementing the `APIManagerProtocol` for making network requests.
class NetworkManager: APIManagerProtocol {
    
    /// The session used for making network requests.
    private let session: URLSession
    
    /// Initializes a new `NetworkManager` instance.
    init() {
        session = URLSession.shared
    }
    
    /// Performs a network request using the specified API configuration.
    ///
    /// - Parameters:
    ///   - apiConfig: The API configuration specifying the request details.
    ///   - resultBlock: The completion handler called when the request is complete.
    func request<T: Decodable>(useConfig apiConfig: APIConfig,
                               resultBlock: @escaping completionHandler<T>) {
        let url = URL(string: apiConfig.baseURL.path + apiConfig.endPoint)
        var request = URLRequest(url: url!, timeoutInterval: Double.infinity)
        
        // Add authorization header if a token exists
        if let token = UserDefaults.standard.string(forKey: "authToken"), !token.isEmpty {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }
        
        request.httpMethod = apiConfig.httpMethod.rawValue
        
        // Add request body if query parameters exist
        if let params = encodeParameter(params: apiConfig.queryParameter), !params.isEmpty {
            request.httpBody = params
        }
        
        session.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                resultBlock(.failure(ApiError.invalidResponse))
                return
            }
            
            let statusCode = response.statusCode
            
            switch statusCode {
            case 200 ... 299:
                do {
                    let decodedObject = try JSONDecoder().decode(T.self, from: data!)
                    resultBlock(.success(decodedObject))
                } catch let error {
                    debugPrint("Error: \(error)")
                    resultBlock(.failure(ApiError.decodingFailed))
                }
                
            case 400 ... 599:
                do {
                    let errorResponse = try JSONDecoder().decode(ErrorInfo.self, from: data!)
                    let errorType: ApiError
                    if 400 ... 499 ~= statusCode {
                        errorType = .customError(ErrorModel(code: "400", message: errorResponse.message))
                    } else {
                        errorType = .requestFailed
                    }
                    resultBlock(.failure(errorType))
                } catch let error {
                    debugPrint("Error: \(error)")
                    resultBlock(.failure(ApiError.requestFailed))
                }
                
            default:
                do {
                    let errorResponse = try JSONDecoder().decode(ErrorInfo.self, from: data!)
                    let errorType: ApiError = .customError(ErrorModel(code: "unKnown", message: errorResponse.message))
                    resultBlock(.failure(errorType))
                } catch let error {
                    debugPrint("Error: \(error)")
                    resultBlock(.failure(ApiError.requestFailed))
                }
            }
        }.resume()
    }
    
    /// Encodes parameters into a format suitable for a request body.
    ///
    /// - Parameter params: The parameters to be encoded.
    /// - Returns: The encoded data representing the parameters.
    func encodeParameter(params: [String: Any]) -> Data? {
        var encodedParameters = ""
        for (key, value) in params {
            if let encodedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let encodedValue = (value as AnyObject).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                encodedParameters += "\(encodedKey)=\(encodedValue)&"
            }
        }
        
        // Remove the trailing "&" if there are parameters
        if !encodedParameters.isEmpty {
            encodedParameters.removeLast()
        }
        
        print(encodedParameters)
        return encodedParameters.data(using: .utf8) ?? nil
    }
}




