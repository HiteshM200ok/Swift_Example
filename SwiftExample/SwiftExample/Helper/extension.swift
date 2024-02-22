//
//  extension.swift
//  SwiftExample
//
//  Created by 200OK-IOS5 on 31/01/24.
//

import Foundation
import UIKit

extension UIStoryboard {
    static var sb: UIStoryboard {
        return UIStoryboard(name: screen.storyBoard.indentifier, bundle: Bundle.main)
    }
}

extension NSObject {
    class var className: String {
        return "\(self)"
    }
}

extension UITextField {
    func validateTextField() -> Bool {
        guard let text = self.text, !text.isEmpty else {
            // Text field is empty
            return false
        }
        return true
    }
}

extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: Constant.alert, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constant.ok, style: .default, handler: nil)
         alert.addAction(okAction)
         present(alert, animated: true, completion: nil)
     }
}

extension UITableView {
    func register<T: UITableViewCell>(_ name: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: name))
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }
}

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
