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
    var currentUser: User?
    static let shared = FirebaseSession()
    var viewRouter = ViewRouter()
    var handle: AuthStateDidChangeListenerHandle?
    let db = Firestore.firestore()

    func listen() {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { [self] (auth, user) in
            if let user = user {
                self.viewRouter.viewRouter = "Dashboard"
                // if we have a user, create a new user model
                print("Got user: \(user)")
                    
                self.loggedInUser = User(email: user.email, username: user.displayName, uid: user.uid,  items: [], labels: [], progress: 0, following: [], followingProgress: [])
                self.currentUser = User(email: user.email, username: user.displayName, uid: user.uid,  items: [], labels: [], progress: 0, following: [], followingProgress: [])
                self.loggedInUser?.uid = user.uid
                self.currentUser?.uid = user.uid
                self.retrieveItems()
                self.retrieveLabels()
                self.retrieveProgress()
                addUser()
                self.retrieveFollowing()
                
            } else {
                // if we don't have a user, set our session to nil
                self.loggedInUser = nil
                viewRouter.viewRouter = "Sign In"
            }
        }
    }
    
    func addUser() {
        
        let userLocation = db.collection("users")
        
        userLocation.document((loggedInUser?.email)!).setData(["dummy": "dummy"], merge: true)

        userLocation.document((loggedInUser?.email)!).collection("UserID").document((loggedInUser?.uid)!).setData([
            "uid": (loggedInUser?.uid!)! as String,
            "progress": (loggedInUser!.progress) as Double
        ]) { error in

            if let error = error {

                print("error saving user: \(error)")

            } else {

                print("succesfully saved user")
            }
        }
    }
    
    func findUser(email: String) {
        
        let email = email.lowercased()
        let userLocation = db.collection("users").document(email)
        
        userLocation.getDocument { (document, error) in
        
            if let document = document, document.exists {
                
                print("user found")
                var uid = ""
                var progress: Double = 0
                document.reference.collection("UserID").getDocuments { (documents, error) in

                    if (error == nil) {

                        for document in documents!.documents {
                            
                            uid = document.get("uid") as! String
                            progress = document.get("progress") as! Double
                            self.followUser(uid: uid, email: email, progress: progress)
                        }
                    }
                }
                
            } else {
                
                print("user doesn't exist")
            }
        }
    }
    
    func unfollowUser(email: String) {
        
        let followingLocation = db.collection("users").document(email)
        let currentLocation = db.collection("users").document(loggedInUser!.email!).collection("following")
        var uid = ""
        
        followingLocation.getDocument { (document, error) in
            
            if let document = document, document.exists {
                
                document.reference.collection("UserID").getDocuments { (documents, error) in
                    
                    if (error == nil) {
                        
                        for document in documents!.documents {
                            
                            uid = document.get("uid") as! String
                        }
                        
                        currentLocation.document(uid).delete()
                    }
                }
            }
        }
    }
    
    func followUser(uid: String, email: String, progress: Double) {
        
        let userLocation = db.collection("users").document((loggedInUser?.email!)!).collection("following").document(uid)
        
        userLocation.setData(["uid": uid, "email": email, "progress": progress], merge: true)
    }
    
    func retrieveFollowing() {
        
        let followersLocation = db.collection("users").document((loggedInUser?.email!)!).collection("following")
        var following: Array<String> = []
        var followingProgress: Array<Double> = []
        
        followersLocation.getDocuments { (documents, error) in
            
            if (error == nil) {
                
                for document in documents!.documents {
                    
                    print(document.data())
                    
                    self.findUser(email: document.get("email") as! String)
                    
                    following.append(document.get("email") as! String)
                    followingProgress.append(document.get("progress") as! Double)
                    
                }
                
                self.loggedInUser?.following = following
                self.loggedInUser?.followingProgress = followingProgress
                
            } else {
                
                print("there was an error: \(error!)")
                
            }
        }
    }
    
    func deleteItem(item: Item) {
        
        let itemsLocation = db.collection("data").document(loggedInUser!.uid!).collection("items")
        
        itemsLocation.document(item.getTitle()).delete() { error in
            if let error = error {
                
                print("Error removing document: \(error)")
                
            } else {
                
                print("Document successfully removed!")
            }
        }
    }
    
    func saveItem(item: Item) {
        
        let itemsLocation = db.collection("data").document(loggedInUser!.uid!).collection("items")
        
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
        let itemsLocation = db.collection("data").document(loggedInUser!.uid!).collection("items")
        
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
        
        let progressRef = db.collection("data").document(loggedInUser!.uid!).collection("progress")
        let userProgress = db.collection("users").document(loggedInUser!.email!).collection("UserID").document(loggedInUser!.uid!)
        var progress: Double = 0

        progressRef.getDocuments() { querySnapshot, error in

            if let error = error {

                print("Error getting documents: \(error)")
                return

            } else {

                for document in querySnapshot!.documents {

                    progress = document.get("progress") as! Double
                    userProgress.setData(["progress": progress], merge: true)
                }

                self.loggedInUser?.progress = progress
            }
        }
    }
    
    func saveProgress(progress: Double) {
        
        let progressLocation = db.collection("data").document(loggedInUser!.uid!).collection("progress")
        let userLocation = db.collection("users").document(loggedInUser!.email!).collection("UserID").document(loggedInUser!.uid!)
        
        userLocation.setData(["progress": progress], merge: true)
        
        progressLocation.document("progress").setData([
            
            "progress": progress
            
            ],
            merge: true) { error in
                
                if let error = error {
                    
                    print("Error writing document: \(error)")
                    
                } else {
                    
                    self.addUser()
                    print("Saved progress succesfully!")
                }
        }
    }
    
    func retrieveLabels() {
        
        let labelsRef = db.collection("data").document(loggedInUser!.uid!).collection("labels")
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
        
        let labelLocation = db.collection("data").document(loggedInUser!.uid!).collection("labels")
        
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
        
        let itemsRef = db.collection("data").document(loggedInUser!.uid!).collection("items")
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
    
    func deleteUserData() {
        
        retrieveItems()
        retrieveLabels()
        retrieveProgress()
        retrieveFollowing()
       
        let userPath = db.collection("data").document(Auth.auth().currentUser!.uid)
        let itemPath = userPath.collection("items")
        let labelPath = userPath.collection("labels")
        let progressPath = userPath.collection("progress")
        let userIDPath = db.collection("users").document((loggedInUser?.email)!).collection("UserID").document((loggedInUser?.uid!)!)
        let followingPath = db.collection("users").document((loggedInUser?.email!)!).collection("following")
    
        for item in self.loggedInUser!.items {
            
            itemPath.document(item.getTitle()).delete()
        }
        
        for label in self.loggedInUser!.labels {
            
            labelPath.document(label).delete()
        }
        
        progressPath.document("progress").delete()
        userIDPath.delete()
       
        followingPath.getDocuments { documents, error in
            
            if (error == nil) {
                
                for document in documents!.documents {
                    
                    followingPath.document(document.documentID).delete()
                }
            }
        }
        
        db.collection("users").document((loggedInUser?.email!)!).delete()
        
        db.collection("data").document(Auth.auth().currentUser!.uid).delete() { err in
            
            if let error = err {
                
                print("Error removing data: \(error)")
                
            } else {
                
                print("User data succesfully deleted.")
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
        
        currentUser = User(email: Auth.auth().currentUser?.email, username: Auth.auth().currentUser?.displayName, uid: Auth.auth().currentUser?.uid,  items: [], labels: [], progress: 0, following: [], followingProgress: [])
        currentUser!.updateStoredPassword(password)
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
    
    func updateEmail(password: String, newEmail: String) {
           
        Auth.auth().currentUser?.updateEmail(to: newEmail) { error in
        
            if ((error) != nil) {
                
                print(error!.localizedDescription)
                self.reauthenticate(password: password)
            }
        }
    }
    
    func updatePassword(oldPassword: String, newPassword: String) {
        
        Auth.auth().currentUser?.updatePassword(to: newPassword) { (error) in
          
            if((error) != nil) {
                
                print(error!.localizedDescription)
                self.reauthenticate(password: oldPassword)
            }
        }
        
        currentUser!.updateStoredPassword(newPassword)
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
    
    func delete(password: String) {
        
        let user = Auth.auth().currentUser
        self.deleteUserData()
        
        user?.delete { error in
            
            if let error = error {
                
                print("There was an error while deleting the user: \(error)")
                self.reauthenticate(password: password)
                
            } else {
                
                print("User succesfully deleted.")
                self.currentUser = nil
            }
        }
    }
}
