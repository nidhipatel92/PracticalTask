//
//  UserModel.swift
//  Task-Nidhi
//
//  Created by Nidhi patel on 03/05/23.
//

import Foundation
import UIKit

struct UserModel : Codable {
    var name: String
    var email: String
    var password: String
    var mobile: String
//    var idValue: String
    
    init(name: String, email: String, password: String, mobile: String) {
        self.name = name
        self.email = email
        self.password = password
        self.mobile = mobile
    }
}
