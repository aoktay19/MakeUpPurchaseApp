//
//  specialListAddingDelegate.swift
//  MakeUpProductApp
//
//  Created by Ali Oktay on 8.01.2024.
//

import Foundation

protocol SpecialListAddingDelegate {
    //func addMakeup(_ makeUp: MakeUp)
    var makeUpProductList: [MakeUp] {get set}
}
