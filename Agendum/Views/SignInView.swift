//
//  SignInView.swift
//  Agendum
//
//  Created by Sian Pike on 14/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    
    @State var usernameOrEmail: String = ""
    @State var password: String = ""
    @State var loading = false
    @State var error = false
    @ObservedObject var viewRouter: ViewRouter
    
    @EnvironmentObject var session: FirebaseSession
    
    func signIn() {
        loading = true
        error = false
        let emailAsString = $usernameOrEmail.wrappedValue
        let passwordAsString = $password.wrappedValue
        
        session.signIn(email: emailAsString, password: passwordAsString) { (result, error) in
            self.loading = false
            if error != nil {
                self.error = true
            } else {
                self.usernameOrEmail = ""
                self.password = ""
                self.viewRouter.viewRouter = "Dashboard"
            }
        }
    }
    
    var body: some View {
        
            VStack {
                
                Text("S i g n  I n")
                    .font(Font.custom("Montserrat-Medium", size: 30))
                    .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))

                VStack {
                    TextField("U s e r n a m e  o r  E m a i l", text: $usernameOrEmail)
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

                ButtonOne(text: "S I G N  I N", color: Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0), action: {
                    self.signIn()
                    }).padding()
                
                FaceBookLoginView(viewRouter: viewRouter).frame(height: 40).padding(.horizontal)
                
                ButtonOne(text: "S I G N  U P", color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), action: {
                    self.viewRouter.viewRouter = "Sign Up"
                    
                }).padding()
                
                
                if (error) {
                    Text("error")
                }
                
            }.padding()
        }
    }


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(viewRouter: ViewRouter()).environmentObject(FirebaseSession(viewRouter: ViewRouter()))
    }
}
