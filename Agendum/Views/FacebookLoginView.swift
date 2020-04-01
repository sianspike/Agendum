//
//  FacebookLoginView.swift
//  Agendum
//
//  Created by Sian Pike on 30/03/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI
import FBSDKLoginKit
import FirebaseAuth

struct FaceBookLoginView: UIViewRepresentable {
    
    @ObservedObject var goToDashboard: GoToDashboard

    func makeCoordinator() -> FaceBookLoginView.Coordinator {
    
        return FaceBookLoginView.Coordinator(goToDashboard: goToDashboard)
    }

    func makeUIView(context: UIViewRepresentableContext<FaceBookLoginView>) -> FBLoginButton {
        let loginButton = FBLoginButton()
        loginButton.permissions = ["email"]
        loginButton.delegate = context.coordinator
        return loginButton
    }

    func updateUIView(_ uiView: FBLoginButton, context: UIViewRepresentableContext<FaceBookLoginView>) { }

    class Coordinator: NSObject, LoginButtonDelegate {
        
        @ObservedObject var goToDashboard: GoToDashboard
        
        init(goToDashboard: GoToDashboard) {
            self.goToDashboard = goToDashboard
            super.init()
        }
    
        func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
            if let error = error {
                print(error.localizedDescription)
                return
            }
        
        if (AccessToken.current != nil) {
        
            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    print(error.localizedDescription)
                    self.goToDashboard.goToDashboard = false
                    return
                }
                
                self.goToDashboard.goToDashboard = true
            }
        }
    }
    
        func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
            try! Auth.auth().signOut()
        }
    }
}

