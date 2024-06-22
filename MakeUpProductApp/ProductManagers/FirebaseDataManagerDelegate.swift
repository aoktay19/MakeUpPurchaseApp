//
//  FirebaseDataManagerDelegate.swift
//  MakeUpProductApp
//
//  Created by Ali Oktay on 17.01.2024.
//

import Foundation

protocol FirebaseDataManagerDelegate {
    func fetchProductList(userId: String)
    func addToProductList(makeUp: MakeUp, userId : String, isInit: Bool)
    func removeFromProductList(makeUp: MakeUp, userId : String)
}
