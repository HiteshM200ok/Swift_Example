//
//  Util.swift
//  SwiftExample
//
//  Created by 200OK-IOS5 on 21/02/24.
//

import Foundation
import UIKit

class Util {
    static func validateTextField(textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else {
            // Text field is empty
            return false
        }
        return true
    }
}
