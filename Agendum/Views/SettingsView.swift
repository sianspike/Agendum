//
//  SettingsView.swift
//  Agendum
//
//  Created by Sian Pike on 27/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var session: FirebaseSession
    @ObservedObject var viewRouter: ViewRouter
    @State private var touchID = false
    @State private var newEmail = ""
    @State private var changeEmailShowing = false
    @State private var userAuthenticated = false
    @State private var authError = false
    @State private var password = ""
    
    func signOut() {
        
        let signedOut = self.session.signOut()
        
        if (signedOut) {
            self.viewRouter.viewRouter = "Sign In"
            return
        }
        
        print("error signing out")
    }

    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                TextWithBottomBorder(text: "S e t t i n g s")
                
                ButtonOne(text: "C H A N G E  E M A I L", color: Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0), action: {
                    
                    userAuthenticated = true
                    
                })
                .padding()
                .alert(isPresented: $authError) {
                    
                    Alert(title: Text("Error"), message: Text("Authentication Failed"), dismissButton: .default(Text("OK")))
                }
            
                ButtonOne(text: "C H A N G E  P A S S W O R D", color: Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0), action: {}).padding()
                
                ButtonOne(text: "C O N N E C T  C A L E N D A R", color: Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0), action: {}).padding()
                
                HStack{
                    
                    Toggle(isOn: $touchID) {
                        
                        Text("T o u c h  I D")
                            .font(Font.custom("Montserrat-Regular", size: 15))
     
                    }.padding()
                }
                
                Spacer()
                
                ButtonOne(text: "L O G  O U T", color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), action: {
                    
                    self.signOut()
                }).padding()
                
                ButtonOne(text: "D E L E T E  A C C O U N T", color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), action: {}).padding()
            }
            
            if (changeEmailShowing) {
                
                CustomAlertView(textEntered: $newEmail, alertTitle: "Change Email", placeholder: "New Email", dismissText: "Submit", action: {
                    
                    session.updateEmail(newEmail: $newEmail.wrappedValue)
                    changeEmailShowing = false
                })
            }
            
            if (userAuthenticated) {
                
                CustomAlertView(textEntered: $password, alertTitle: "Reauthenticate", placeholder: "Password", dismissText: "OK", action: {
                    
                    session.reauthenticate(password: $password.wrappedValue)
                    
                    userAuthenticated = false
                    changeEmailShowing = true
                })
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewRouter: ViewRouter())
    }
}
