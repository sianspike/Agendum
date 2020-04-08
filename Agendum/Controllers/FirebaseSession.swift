//
//  FirebaseSession.swift
//  Agendum
//
//  Created by Sian Pike on 17/03/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import Foundation
import Firebase
import Combine
import SwiftUI
import FBSDKLoginKit

class FirebaseSession: NSObject, ObservableObject {
    
    @Published var loggedInUser: User?
    var viewRouter = ViewRouter()
    
    static let shared = FirebaseSession()
    var handle: AuthStateDidChangeListenerHandle?

    func listen () {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // if we have a user, create a new user model
                self.viewRouter.viewRouter = "Dashboard"
                print("Got user: \(user)")
                self.loggedInUser = User(
                    uid: user.uid,
                    email: user.email,
                    username: user.displayName
                )
                
            } else {
                // if we don't have a user, set our session to nil
                self.loggedInUser = nil
                self.viewRouter.viewRouter = "Sign Up"
            }
        }
    }

    
    func signUp(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
        ) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    func fbSignUp(with: AuthCredential, handler: @escaping AuthDataResultCallback) {
        
        Auth.auth().signIn(with: with, completion: handler)
    }

    func signIn(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
        ) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }

    func signOut () -> Bool {
        do {
            try Auth.auth().signOut()
            self.loggedInUser = nil
            return true
        } catch {
            return false
        }
    }
    
    func unbind () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
