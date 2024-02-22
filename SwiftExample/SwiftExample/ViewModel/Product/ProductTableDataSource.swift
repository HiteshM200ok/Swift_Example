//
//  ProductTableDataSource.swift
//  SwiftExample
//
//  Created by 200OK-IOS5 on 21/02/24.
//

import UIKit

/// A data source class for the product table view.
class ProductTableDataSource: NSObject, UITableViewDataSource {
    
    /// An array holding the products to be displayed in the table view.
    var products: [Product] = []
    
    /// Returns the number of rows in the specified section of the table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    /// Asks the data source for a cell to insert in a particular location of the table view.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue a reusable cell with the identifier "ProductCell" for the given index path
        let cell: ProductCell = tableView.dequeueReusableCell(for: indexPath)
        // Retrieve the product at the current index path
        let product = products[indexPath.row]
      
        // Configure the cell using the retrieved product
        cell.configure(with: product)
        
        // Return the configured cell
        return cell
    }
}

