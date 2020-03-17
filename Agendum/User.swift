//
//  User.swift
//  Agendum
//
//  Created by Sian Pike on 17/03/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import Foundation

class User {
    
    var email : String?
    var username : String?
    var uid : String
    
    init(uid: String, email : String?, username : String?) {
        self.uid = uid
        self.email = email
        self.username = username
    }
}
