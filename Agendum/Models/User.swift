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
    var uid: String?
    var items: Array<Item>
    var labels: Array<String>
    var progress: Double
    var following: Array<String>
    
    func getStoredPassword() -> String {
        
        let kcw = KeychainWrapper()
        
        if let password = try? kcw.getGenericPasswordFor(
            account: "Agendum",
            service: "unlockPassword") {
            
            return password
        }
        
        return ""
    }
    
    func updateStoredPassword(_ password: String) {
        
        let kcw = KeychainWrapper()
        
        do {
            
            try kcw.storeGenericPasswordFor(
                account: "Agendum",
                service: "unlockPassword",
                password: password)
            
        } catch let error as KeychainWrapperError {
            
            print("Exception setting password: \(error.message ?? "no message")")
            
        } catch {
            
            print("An error occured setting the password.")
        }
    }
}
