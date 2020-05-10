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

class FirebaseSession: ObservableObject {
    
    @Published var loggedInUser: User?
    static let shared = FirebaseSession()
    var viewRouter = ViewRouter()
    var handle: AuthStateDidChangeListenerHandle?
    let db = Firestore.firestore()

    func listen() {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                self.viewRouter.viewRouter = "Dashboard"
                // if we have a user, create a new user model
                print("Got user: \(user)")
                self.loggedInUser = User(email: user.email, username: user.displayName, uid: user.uid,  items: [])
                self.retrieveItems()
            } else {
                // if we don't have a user, set our session to nil
                self.loggedInUser = nil
                self.viewRouter.viewRouter = "Sign In"
            }
        }
    }
    
    func saveItems(items: Array<Item>) {
        let itemsLocation = db.collection("users").document(loggedInUser!.uid).collection("items")
        
        for item in items {
            
            itemsLocation.document(item.getTitle()).setData([
                "title": item.getTitle(),
                "task": item.isTask(),
                "habit": item.isHabit(),
                "dateToggle": item.isDateSet(),
                "date": item.getDate() as Any,
                "reminderToggle": item.isReminderSet(),
                "reminder": item.getReminderDate() as Any,
                "labels": item.getLabels(),
                "completed": item.isCompleted()
            ], merge: true) { error in
                
                if let error = error {
                    
                    print("Error writing document: \(error)")
                    
                } else {
                    
                    print("Saved items succesfully!")
                }
            }
        }
    }
    
    func retrieveItems() {
        
        let itemsRef = db.collection("users").document(loggedInUser!.uid).collection("items")
        var itemArray: Array<Item> = []
        
        itemsRef.getDocuments() { querySnapshot, error in
            
                if let error = error {
                    
                    print("Error getting documents: \(error)")
                    return
                    
                } else {
                    
                    for document in querySnapshot!.documents {
                        
                        let title = document.get("title") as! String
                        let task = document.get("task") as! Bool
                        let habit = document.get("habit") as! Bool
                        let dateToggle = document.get("dateToggle") as! Bool
                        let date = document.get("date") as? Date
                        let reminderToggle = document.get("reminderToggle") as! Bool
                        let reminder = document.get("reminder") as? Date
                        let completed = document.get("completed") as! Bool
                        let labels = document.get("labels") as? Array<String>
                    
                        itemArray.append(Item(title: title, task: task, habit: habit, dateToggle: dateToggle, date: date ?? nil, reminderToggle: reminderToggle, reminder: reminder ?? nil, completed: completed, labels: labels ?? []))
                    }
                    
                    self.loggedInUser?.items = itemArray
                }
        }
    }

    func addUsername(username: String) {
        
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = username
        changeRequest?.commitChanges { error in
            print(error ?? nil)
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
