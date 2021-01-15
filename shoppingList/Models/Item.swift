//
//  Item.swift
//  shoppingList
//
//  Created by Chris Withers on 1/15/21.
//

import Foundation

class Item: Codable {
    let title: String
    var hasBought: Bool
    var amount: Int
    
    init(title: String, hasBought: Bool = false, amount: Int = 1) {
        self.title = title
        self.hasBought = hasBought
        self.amount = amount
    }
}

extension Item: Equatable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.title == rhs.title && lhs.hasBought == rhs.hasBought
    }
    
    
}
