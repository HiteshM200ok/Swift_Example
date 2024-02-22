//
//  UserRepository.swift
//  SwiftExample
//
//  Created by 200OK-IOS5 on 31/01/24.
//

import Foundation

/// Type alias for an authentication response containing either an `AuthUser` or an error message.
typealias authResponse = (AuthUser?, String?) -> Void

/// Type alias for a user response containing either a `User` or an error message.
typealias userResponse = (User?, String?) -> Void

/// Protocol defining the structure of an authentication repository.
protocol AuthRepositoryProtocol {
    /// Authenticates a user using the specified parameters.
    ///
    /// - Parameters:
    ///   - params: The parameters for user authentication.
    ///   - completion: The completion handler called when the authentication is complete.
    func authUser(useParameter params: Parameter, completion: @escaping authResponse)
    
    /// Retrieves user details.
    ///
    /// - Parameter completion: The completion handler called when user details are retrieved.
    func getUserDetail(completion: @escaping userResponse)
}

/// Class implementing the `AuthRepositoryProtocol` for handling authentication and user details.
class AuthRepository: AuthRepositoryProtocol {
    /// The network manager responsible for making API requests.
    var networkManager: NetworkManager
    
    /// Initializes a new `AuthRepository` instance with a default `NetworkManager`.
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    /// Authenticates a user using the specified parameters.
    ///
    /// - Parameters:
    ///   - params: The parameters for user authentication.
    ///   - completion: The completion handler called when the authentication is complete.
    func authUser(useParameter params: Parameter, completion: @escaping authResponse) {
        let networkConfig = APIConfig(endPoint: APIEndPoints.login.url,
                                      httpMethod: HTTPMethodType.post,
                                      queryParameter: params)
        
        self.networkManager.request(useConfig: networkConfig) { (result: Result<AuthUser, ApiError>) in
            switch result {
            case .success(let user):
                debugPrint("Auth User: \(user)")
                completion(user, nil)
            case .failure(let err):
                completion(nil, err.errorDescription)
            }
        }
    }
    
    /// Retrieves user details.
    ///
    /// - Parameter completion: The completion handler called when user details are retrieved.
    func getUserDetail(completion: @escaping userResponse) {
        let networkConfig = APIConfig(endPoint: APIEndPoints.auth.url,
                                      httpMethod: HTTPMethodType.get)
        
        self.networkManager.request(useConfig: networkConfig) { (result: Result<User, ApiError>) in
            switch result {
            case .success(let user):
                debugPrint("User details: \(user)")
                completion(user, nil)
            case .failure(let err):
                completion(nil, err.errorDescription)
            }
        }
    }
}
