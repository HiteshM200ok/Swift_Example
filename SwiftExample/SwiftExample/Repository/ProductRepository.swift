//
//  ProductViewRepository.swift
//  SwiftExample
//
//  Created by 200OK-IOS5 on 21/02/24.
//

import Foundation

/// Type alias for a product response containing either a `Products` object or an error message.
typealias productResponse = (Products?, String?) -> Void

/// Protocol defining the structure of a product repository.
protocol ProductRepositoryProtocol {
    /// Retrieves a list of products.
    ///
    /// - Parameter completion: The completion handler called when the product list is retrieved.
    func getProducts(completion: @escaping productResponse)
}

/// Class implementing the `ProductRepositoryProtocol` for handling product-related API requests.
class ProductRepository: ProductRepositoryProtocol {
    /// The network manager responsible for making API requests.
    var networkManager: NetworkManager
    
    /// Initializes a new `ProductRepository` instance with a default `NetworkManager`.
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    /// Retrieves a list of products.
    ///
    /// - Parameter completion: The completion handler called when the product list is retrieved.
    func getProducts(completion: @escaping productResponse) {
        let networkConfig = APIConfig(endPoint: APIEndPoints.products.url,
                                      httpMethod: HTTPMethodType.get)
        
        self.networkManager.request(useConfig: networkConfig) { 
            (result: Result<Products, ApiError>) in
            switch result {
            case .success(let products):
                debugPrint("List of products: \(products)")
                completion(products, nil)
            case .failure(let err):
                completion(nil, err.errorDescription)
            }
        }
    }
}

