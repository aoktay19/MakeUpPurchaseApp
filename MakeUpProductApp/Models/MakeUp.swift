//
//  MakeUp.swift
//  MakeUpProductApp
//
//  Created by Ali Oktay on 7.01.2024.
//

import Foundation

struct MakeUp: Codable, Hashable {
    var id: Int
    var brand: String?
    var name: String?
    var price: String?
    var image_link: String?
    var description: String?
    var rating: Double?
    var category: String?
    var product_type: String?
}
