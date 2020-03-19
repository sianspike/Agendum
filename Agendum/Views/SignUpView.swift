//
//  SignUpView.swift
//  Agendum
//
//  Created by Sian Pike on 07/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FBSDKLoginKit

struct SignUpView: View {
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var loading = false
    @State var error = false
    @State var goToSignIn = false
    
    @EnvironmentObject var session: FirebaseSession
    
    @ObservedObject var viewRouter: ViewRouter
    
    func signUp() {
        loading = true
        error = false
        let emailAsString = $email.wrappedValue
        let passwordAsString = $password.wrappedValue
        
        session.signUp(email: emailAsString, password: passwordAsString) { (result, error) in
            self.loading = false
            if error != nil {
                self.error = true
            } else {
                self.email = ""
                self.password = ""
                self.viewRouter.currentPage = "Dashboard"
            }
        }
    }
    
    func fbSignUp() {
        
        if (AccessToken.current != nil) {
            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            
            session.fbSignUp(with: credential) { (result, error) in
                
                if (error != nil) {
                    print((error?.localizedDescription)!)
                    return
                } else {
                    self.viewRouter.currentPage = "Dashboard"
                }
            }
        }
    }
    
    var body: some View {
        
        VStack {
            
            Text("S i g n  U p")
                .font(Font.custom("Montserrat-Medium", size: 30))
                .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
            
            VStack {
                TextField("U s e r n a m e", text: $username)
                    .multilineTextAlignment(TextAlignment.center)
                    .font(Font.custom("Montserrat-Regular", size: 20))
                HorizontalLineShape
                    .HorizontalLine(color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), height: 3, width: .infinity)
            }.padding()
            
            VStack {
                TextField("E m a i l", text: $email)
                    .multilineTextAlignment(TextAlignment.center)
                    .font(Font.custom("Montserrat-Regular", size: 20))
                    HorizontalLineShape
                        .HorizontalLine(color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), height: 3, width: .infinity)
            }.padding()
            
            VStack {
                SecureField("P a s s w o r d", text: $password)
                    .multilineTextAlignment(TextAlignment.center)
                    .font(Font.custom("Montserrat-Regular", size: 20))
                    HorizontalLineShape
                        .HorizontalLine(color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), height: 3, width: .infinity)
            }.padding()
            
            Text("\(email)")
            
            ButtonOne(text: "C R E A T E  A C C O U N T", color: Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0), action: {
                self.signUp()
            })
                .padding(.bottom)
            
            ButtonOne(text: "S I G N  U P  W I T H  F A C E B O O K", color: Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0), action: {self.fbSignUp()})
            
            ButtonOne(text: "S I G N  I N", color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), action: {self.viewRouter.currentPage = "Sign In"})
            
        }.padding()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewRouter: ViewRouter())
    }
}
