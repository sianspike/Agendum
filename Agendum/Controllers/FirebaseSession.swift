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
import LocalAuthentication

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
                
                if (self.loggedInUser == nil) {
                    
                    self.loggedInUser = User(email: user.email, username: user.displayName, uid: user.uid,  items: [], labels: [], progress: 0)
                }
                self.loggedInUser?.uid = user.uid
                self.retrieveItems()
                self.retrieveLabels()
                self.retrieveProgress()
            } else {
                // if we don't have a user, set our session to nil
                self.loggedInUser = nil
                self.viewRouter.viewRouter = "Sign In"
            }
        }
    }
    
    func deleteItem(item: Item) {
        
        let itemsLocation = db.collection("users").document(loggedInUser!.uid!).collection("items")
        
        itemsLocation.document(item.getTitle()).delete() { error in
            if let error = error {
                
                print("Error removing document: \(error)")
                
            } else {
                
                print("Document successfully removed!")
            }
        }
    }
    
    func saveItem(item: Item) {
        
        let itemsLocation = db.collection("users").document(loggedInUser!.uid!).collection("items")
        
        for existingItems in loggedInUser!.items {
            
            if (existingItems.getTitle() == item.getTitle()) {
                
                itemsLocation.document(item.getTitle()).setData([
                    "title": item.getTitle(),
                    "task": item.isTask(),
                    "habit": item.isHabit(),
                    "dateToggle": item.isDateSet(),
                    "date": item.getDate() as Any,
                    "reminderToggle": item.isReminderSet(),
                    "reminder": item.getReminderDate() as Any,
                    "labels": item.getLabels(),
                    "completed": item.isCompleted(),
                    "event": item.isEvent(),
                    "duration": item.getDuration() as Any
                ], merge: true) { error in
                    
                    if let error = error {
                        
                        print("Error writing document: \(error)")
                        
                    } else {
                        
                        print("Saved items succesfully!")
                    }
                }
            }
        }
    }
    
    func saveItems(items: Array<Item>) {
        let itemsLocation = db.collection("users").document(loggedInUser!.uid!).collection("items")
        
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
                "completed": item.isCompleted(),
                "event": item.isEvent(),
                "duration": item.getDuration() as Any
            ], merge: true) { error in
                
                if let error = error {
                    
                    print("Error writing document: \(error)")
                    
                } else {
                    
                    print("Saved items succesfully!")
                }
            }
        }
    }
    
    func retrieveProgress() {
        
        let progressRef = db.collection("users").document(loggedInUser!.uid!).collection("progress")
        var progress: Double = 0

        progressRef.getDocuments() { querySnapshot, error in

            if let error = error {

                print("Error getting documents: \(error)")
                return

            } else {

                for document in querySnapshot!.documents {

                    progress = document.get("progress") as! Double
                }

                self.loggedInUser?.progress = progress
            }
        }
    }
    
    func saveProgress(progress: Double) {
        
        let progressLocation = db.collection("users").document(loggedInUser!.uid!).collection("progress")
        
        progressLocation.document("progress").setData([
            
            "progress": progress
            
            ],
            merge: true) { error in
                
                if let error = error {
                    
                    print("Error writing document: \(error)")
                    
                } else {
                    
                    print("Saved progress succesfully!")
                }
        }
    }
    
    func retrieveLabels() {
        
        let labelsRef = db.collection("users").document(loggedInUser!.uid!).collection("labels")
        var labelArray: Array<String> = []
        
        labelsRef.getDocuments() { querySnapshot, error in
            
            if let error = error {
                
                print("Error getting documents: \(error)")
                return
                
            } else {
                
                for document in querySnapshot!.documents {
                    
                    labelArray.append(document.documentID)
                }
                
                self.loggedInUser?.labels = labelArray
            }
        }
    }
    
    func saveLabels(labels: Array<String>) {
        
        let labelLocation = db.collection("users").document(loggedInUser!.uid!).collection("labels")
        
        for label in labels {
            
            labelLocation.document(label).setData([
                "name": label]
            , merge: true) { error in
                
                if let error = error {
                    
                    print("Error writing document: \(error)")
                    
                } else {
                    
                    print("Saved labels succesfully!")
                }
            }
        }
    }
    
    func retrieveItems() {
        
        let itemsRef = db.collection("users").document(loggedInUser!.uid!).collection("items")
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
                        let dateTimeStamp = document.get("date") as? Timestamp
                        let date = dateTimeStamp?.dateValue() as NSDate?
                        let reminderToggle = document.get("reminderToggle") as! Bool
                        let reminderTimeStamp = document.get("reminder") as? Timestamp
                        let reminder = reminderTimeStamp?.dateValue() as NSDate?
                        let completed = document.get("completed") as! Bool
                        let labels = document.get("labels") as? Array<String>
                        let event = document.get("event") as! Bool
                        let duration = document.get("duration") as? TimeInterval
                    
                        itemArray.append(Item(title: title, task: task, habit: habit, dateToggle: dateToggle, date: date ?? nil, reminderToggle: reminderToggle, reminder: reminder ?? nil, completed: completed, labels: labels ?? [], event: event, duration: duration ?? nil))
                    }
                    
                    self.loggedInUser?.items = itemArray
                }
        }
    }

    func addUsername(username: String) {
        
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = username
        changeRequest?.commitChanges { error in
            
            if let error = error {
                
                print(error)
            }
        }
    }
    
    func signUp(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
        ) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
        
        self.loggedInUser = User(email: Auth.auth().currentUser?.email, username: Auth.auth().currentUser?.displayName, uid: Auth.auth().currentUser?.uid,  items: [], labels: [], progress: 0)
        loggedInUser!.updateStoredPassword(password)
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
    
    func updateEmail(newEmail: String) {
           
        Auth.auth().currentUser?.updateEmail(to: newEmail) { error in
        
            if ((error) != nil) {
                
                print(error!.localizedDescription)
            }
        }
    }
    
    func updatePassword(newPassword: String) {
        
        Auth.auth().currentUser?.updatePassword(to: newPassword) { (error) in
          
            if((error) != nil) {
                
                print(error!.localizedDescription)
            }
        }
        
        loggedInUser!.updateStoredPassword(newPassword)
    }
    
    func reauthenticate(password: String) {
        
        let user = Auth.auth().currentUser
        var credential: AuthCredential
        
        credential = EmailAuthProvider.credential(withEmail: (user?.email)!, password: password)
        
        user?.reauthenticate(with: credential) { result, error in
            
            if let error = error {
                
                print(error)
                
            }
        }
    }
}
