//
//  User.swift
//  Agendum
//
//  Created by Sian Pike on 17/03/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import Foundation

struct User {
    
    var email: String?
    var username: String?
    var uid: String
    var items: Array<Item>
}
