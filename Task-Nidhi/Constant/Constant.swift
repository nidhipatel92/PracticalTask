//
//  Constant.swift
//  Task-Nidhi
//
//  Created by Nidhi patel on 03/05/23.
//

import Foundation

var userdefault = UserDefaults.standard

struct URLs{
    static let getproduct               = "https://fakestoreapi.com/products"
}

struct Validations {
    static let emptyName                    = "Please enter username"
    static let emptyEmail                   = "Please enter email"
    static let emptyEmailValidation         = "Please enter valid email"
    static let emptyPassword                = "Please enter password"
    
    static let minimumSixCharacterPassword  = "Password should have minimum 6 characters"
    
    static let emptyMobileNo                    = "Please enter mobile number"
    static let emptyConfirmPassword                    = "Please enter confirm password"
    static let emptyPasswordNotMatch                    = "Password did not match"
}

struct Keys {
    static let email                    = "email"
}
