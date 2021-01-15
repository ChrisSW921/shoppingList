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
    
    init(title: String, hasBought: Bool = false) {
        self.title = title
        self.hasBought = hasBought
    }
}

extension Item: Equatable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.title == rhs.title && lhs.hasBought == rhs.hasBought
    }
    
    
}
