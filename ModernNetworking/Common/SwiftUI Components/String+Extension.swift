//
//  String+Extension.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/11.
//

import Foundation


// MARK: - Password and email validation

extension String {
    var isValidEmail2: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var isValidEmail: Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        //regex restricts to Minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character:
        let passwordFormat = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordFormat)
        return passwordPredicate.evaluate(with: self)
        
    }
    
    var isNumeric: Bool {
        Double(self) != nil
    }
    
    var isNotEmpty: Bool {
        !self.isEmpty
    }
    
    func isLessThan(number: Double) -> Bool {
        if !self.isNumeric {
            return false
        }
        guard let value = Double(self) else {
            return false
        }
        return value < number
    }
}
