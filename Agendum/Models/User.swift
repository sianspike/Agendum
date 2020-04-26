//
//  User.swift
//  Agendum
//
//  Created by Sian Pike on 17/03/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import Foundation

final class User {
    
    private var email: String?
    private var username: String?
    private var uid: String
    private var items: Array<Item>
    
    init(uid: String, email: String?, username: String?) {
        self.uid = uid
        self.email = email
        self.username = username
        self.items = []
    }
    
    func setEmail(newEmail: String?) {
        self.email = newEmail
    }
    
    func getEmail() -> String? {
        return self.email
    }
    
    func addItem(item: Item) {
        self.items.append(item)
    }
    
    func removeItem(item: Item) {
        
        let itemTitle = item.getTitle()
         //find item title
    }
}
