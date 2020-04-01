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
    
    @ObservedObject var viewRouter: ViewRouter

    func makeCoordinator() -> FaceBookLoginView.Coordinator {
    
        return FaceBookLoginView.Coordinator(viewRouter: viewRouter)
    }

    func makeUIView(context: UIViewRepresentableContext<FaceBookLoginView>) -> FBLoginButton {
        let loginButton = FBLoginButton()
        loginButton.permissions = ["email"]
        loginButton.delegate = context.coordinator
        return loginButton
    }

    func updateUIView(_ uiView: FBLoginButton, context: UIViewRepresentableContext<FaceBookLoginView>) { }

    class Coordinator: NSObject, LoginButtonDelegate {
        
        @ObservedObject var viewRouter: ViewRouter
        
        init(viewRouter: ViewRouter) {
            self.viewRouter = viewRouter
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
                    return
                }
                
                self.viewRouter.viewRouter = "Dashboard"
            }
        }
    }
    
        func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
            try! Auth.auth().signOut()
        }
    }
}

