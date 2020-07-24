//
//  Order.swift
//  CupcakeCorner
//
//  Created by jc on 2020-07-23.
//  Copyright © 2020 J. All rights reserved.
//

import Foundation

class Order: ObservableObject {
    static let types = ["vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkle = false
            }
        }
    }
    
    @Published var extraFrosting = false
    @Published var addSprinkle = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2
        cost += (Double(type) / 2)
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkle {
            cost += Double(quantity) / 2
        }
        
        return cost 
    }
}
