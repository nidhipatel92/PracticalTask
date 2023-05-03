//
//  ProductModel.swift
//  Task-Nidhi
//
//  Created by Nidhi patel on 03/05/23.
//

import Foundation
import UIKit

// MARK: - WelcomeElement
struct Product: Codable {
    var id: Int?
    var title: String?
    var price: Double?
    var description, category: String?
    var image: String?
    var rating: Rating?
}

// MARK: - Rating
struct Rating: Codable {
    var rate: Double?
    var count: Int?
}
