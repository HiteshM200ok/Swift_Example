//
//  loginScreen.swift
//  SwiftExample
//
//  Created by 200OK-IOS5 on 31/01/24.
//

import Foundation
import UIKit

import UIKit

/// View controller for user login.
class LoginScreen: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var textfieldUserName: UITextField!
    @IBOutlet weak var textfieldPassword: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    /// View model responsible for authentication-related operations.
    var loginViewModel: AuthViewModel? = nil
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the login view model
        loginViewModel = AuthViewModel()
        
        // Set default values for testing
        textfieldUserName.text = Constant.dummyuserName
        textfieldPassword.text = Constant.dummyPassword
        
        // Hide the activity indicator initially
        activityIndicator.isHidden = true
    }
    
    // MARK: - Actions
    
    /// Action triggered when the user attempts to sign in.
    @IBAction func signIn() {
//        // For testing purposes, navigate directly to the product view screen
//        if let vc = self.storyboard?.instantiateViewController(withIdentifier: ProductViewScreen.className) {
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//        return
        
        // Validate username and password
        guard let username = textfieldUserName.text, let password = textfieldPassword.text else {
            showAlert(message: AlertMessages.emptyField)
            return
        }
        
        // Show activity indicator
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        // Perform user sign-in with the login view model
        loginViewModel?.signIn(username: username, password: password) { [weak self] success, errorMessage in
            guard let self = self else { return }
            
            // Update UI on the main thread
            DispatchQueue.main.async {
                // Hide activity indicator
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                
                // Handle login success or failure
                if !success {
                    // Show alert on login failure
                    self.showAlert(message: errorMessage ?? AlertMessages.authError)
                } else {
                    // Handle successful login by navigating to the product view screen
                    debugPrint("Login successfully..!!")
                    if let vc = self.storyboard?.instantiateViewController(withIdentifier: ProductViewScreen.className) {
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        }
    }
}


