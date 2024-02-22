//
//  ProductViewScreen.swift
//  SwiftExample
//
//  Created by 200OK-IOS5 on 21/02/24.
//

import UIKit

/// View controller for displaying a list of products.
class ProductViewScreen: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    /// View model responsible for product-related operations.
    private var productViewModel: ProductViewModel? = nil
    
    /// Data source for the table view displaying products.
    private let productDataSource = ProductTableDataSource()
    
    /// Refresh control for enabling pull-to-refresh functionality.
    private lazy var refreshView: UIRefreshControl = {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        return view
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up pull-to-refresh functionality
        tableView.refreshControl = refreshView
        
        // Hide the back button and set the navigation title
        navigationItem.hidesBackButton = true
        navigationItem.title = NavigationTitle.products
        
        // Initialize the product view model
        productViewModel = ProductViewModel()
        
        // Fetch and display the product list
        getProductList()
    }
    
    // MARK: - Private Methods
    
    /// Fetches the product list from the view model.
    private func getProductList() {
        productViewModel?.getAllProducts(completion: { [weak self] products, error in
            guard let self = self else { return }
            
            // Handle errors, if any
            if let err = error, !err.isEmpty {
                self.showAlert(message: error ?? AlertMessages.problem)
                return
            }
            
            // Update UI on the main thread
            DispatchQueue.main.async {
                // Set the data source for the table view and reload data
                self.tableView.dataSource = self.productDataSource
                self.productDataSource.products = products
                self.refreshView.update(isRefreshing: false)
                self.tableView.reloadData()
            }
        })
    }
    
    /// Triggered when the user performs a pull-to-refresh action.
    @objc private func onRefresh() {
        getProductList()
    }
}
