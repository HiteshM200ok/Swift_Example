//
//  AppDelegate.swift
//  SwiftExample
//
//  Created by 200OK-IOS5 on 31/01/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    /// The main window of the application.
        var window: UIWindow?
        
        /// The message variable used internally in the application (Note: Not used in the provided code snippet).
        private var message: String?
        
        /// Called when the application finishes launching.
        ///
        /// - Parameters:
        ///   - application: The singleton application instance.
        ///   - launchOptions: A dictionary indicating the reason the application was launched (if any).
        /// - Returns: `true` if the application successfully finishes launching; otherwise, `false`.
        func application(_ application: UIApplication, didFinishLaunchingWithOptions
                         launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            // Instantiate the initial view controller from the storyboard
            let controller = UIStoryboard.sb.instantiateViewController(withIdentifier: LoginScreen.className)
            
            // Create a navigation controller with the initial view controller as the root
            let navController = UINavigationController.init(rootViewController: controller)
            
            // Set the navigation controller as the root view controller of the main window
            window?.rootViewController = navController
            
            // Make the window visible
            window?.makeKeyAndVisible()
            
            // Indicate that the application successfully finished launching
            return true
        }
}



