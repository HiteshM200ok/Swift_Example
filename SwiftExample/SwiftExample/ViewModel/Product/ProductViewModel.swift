//
//  ProductViewModel.swift
//  SwiftExample
//
//  Created by 200OK-IOS5 on 21/02/24.
//

import Foundation

/// Type alias for a product list response containing either an array of `Product` objects or an error message.
typealias ProductList = ([Product], String?) -> Void

/// View model class responsible for handling product-related data and interactions.
class ProductViewModel {
    /// The product repository protocol used for retrieving product data.
    private var productRepository: ProductRepositoryProtocol
    
    /// Initializes a new `ProductViewModel` instance with a default `ProductRepository`.
    init(productRepository: ProductRepositoryProtocol = ProductRepository()) {
        self.productRepository = productRepository
    }
    
    /// Retrieves a list of all products.
    ///
    /// - Parameter completion: The completion handler called when the product list is retrieved.
    func getAllProducts(completion: @escaping ProductList) {
        // Call the product repository to get the products
        self.productRepository.getProducts { products, error in
            // Check if there's an error or if products are successfully retrieved
            if error == nil {
                // Extract the products from the response and pass them to the completion handler
                let products = products?.products
                completion(products ?? [], nil)
            } else {
                // Pass an empty product list and the error message to the completion handler
                completion([], error)
            }
        }
    }
}
