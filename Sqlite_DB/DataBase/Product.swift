//
//  Product.swift
//  ReminderWallpaper
//
//  Created by Mac on 25/07/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation

class Product: CustomStringConvertible {
    let id: Int64?
    var name: String
    var email: String
    var mobile: String
    
    
    init(id: Int64, name: String, email: String, mobile: String) {
        self.id = id
        self.name = name
        self.email = email
        self.mobile = mobile

    }
    var description: String {
        return "id = \(self.id ?? 0), name = \(self.name), email = \(self.email) mobile = \(self.mobile)"
    
    }
}
