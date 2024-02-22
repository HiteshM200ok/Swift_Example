//
//  ViewModel.swift
//  SwiftExample
//
//  Created by 200OK-IOS5 on 31/01/24.
//

import Foundation

/// ViewModel class responsible for handling authentication-related data and interactions.
class AuthViewModel {
    /// The authentication repository protocol used for authenticating users and retrieving user details.
    private var authRepository: AuthRepositoryProtocol
    
    /// Initializes a new `AuthViewModel` instance with a default `AuthRepository`.
    init(authRepository: AuthRepositoryProtocol = AuthRepository()) {
        self.authRepository = authRepository
    }
    
    /// Attempts to sign in with the provided username and password.
    ///
    /// - Parameters:
    ///   - username: The username entered by the user.
    ///   - password: The password entered by the user.
    ///   - completion: The completion handler called when the sign-in process is completed.
    func signIn(username: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        // Validate the username
        if !validate(username: username) {
            completion(false, AlertMessages.emptyUsername)
            return
        }
        
        // Validate the password
        if !validate(password: password) {
            completion(false, AlertMessages.emptypassword)
            return
        }
        
        // Prepare parameters for authentication
        let params: [String: String] = [
            "username": username,
            "password": password
        ]
        
        // Submit the authentication request
        submit(params: params) { success in
            if success {
                completion(true, nil) // Successful login
            } else {
                completion(false, AlertMessages.authError)
            }
        }
    }
    
    /// Validates the provided username.
    ///
    /// - Parameter username: The username to be validated.
    /// - Returns: `true` if the username is valid; otherwise, `false`.
    private func validate(username: String) -> Bool {
        // Add validation logic for username
        return !username.isEmpty
    }

    /// Validates the provided password.
    ///
    /// - Parameter password: The password to be validated.
    /// - Returns: `true` if the password is valid; otherwise, `false`.
    private func validate(password: String) -> Bool {
        // Add validation logic for password
        return !password.isEmpty
    }

    /// Submits the authentication request and retrieves user details.
    ///
    /// - Parameters:
    ///   - params: The parameters required for authentication.
    ///   - completion: The completion handler called when the authentication process is completed.
    private func submit(params: Parameter, completion: @escaping (Bool) -> Void) {
        // Use a dispatch group to wait for asynchronous tasks to complete
        let group = DispatchGroup()
        
        // Enter the group and remove any existing auth token
        group.enter()
        UserDefaults.standard.removeObject(forKey: UserDefaultKeys.authToken)
        
        // Perform user authentication
        self.authRepository.authUser(useParameter: params) { authUser, err in
            if err == nil, let authUser = authUser {
                debugPrint("Token Received:- \(authUser.token)")
                UserDefaults.standard.setValue(authUser.token, forKey: UserDefaultKeys.authToken)
                group.leave()
            } else {
                debugPrint(err ?? "")
                group.leave()
            }
        }
        
        // Wait for the first task to complete
        group.wait()
        
        // Enter the group for the next task
        group.enter()
        
        // Retrieve user details
        self.authRepository.getUserDetail() { user, err in
            if err == nil, let user = user {
                debugPrint(user)
                group.leave()
            } else {
                debugPrint(err ?? "")
                group.leave()
            }
            
            // Notify the completion handler about the success or failure of the entire process
            completion(err == nil)
        }
    }
}

