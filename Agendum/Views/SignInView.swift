//
//  SignInView.swift
//  Agendum
//
//  Created by Sian Pike on 14/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI
import Firebase
import LocalAuthentication

@available(iOS 14.0, *)
struct SignInView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var loading = false
    @State var error = false
    @State var errorMessage = ""
    @ObservedObject var viewRouter: ViewRouter
    var biometricsEnabled = Biometrics()
    @EnvironmentObject var session: FirebaseSession
    @State var alert = false
    @AppStorage("biometricsEnabled") var biometrics = false

    
    func signIn(email: String, password: String) {
        loading = true
        error = false
        
        session.signIn(email: email, password: password) { (result, err) in
            self.loading = false
            if err != nil {
                self.error = true
                self.errorMessage = err!.localizedDescription
            } else {
                self.email = ""
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
                    TextField("U s e r n a m e  o r  E m a i l", text: $email)
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
                
                HStack {
                    
                    ButtonOne(text: "S I G N  I N", color: Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0), action: {
                        self.signIn(email: $email.wrappedValue, password: $password.wrappedValue)
                    })
                    .padding()
                    .alert(isPresented: $error) {
                        
                        Alert(title: Text("Authentication Error"), message: Text(errorMessage), dismissButton: .default(Text("Dismiss")))
                    }
                    
                    if (biometrics) {
                        
                        Button(action: {
                            
                            if (biometricsEnabled.tryBiometricAuthentication()) {
                                
                                if (session.currentUser?.email == nil || session.currentUser?.getStoredPassword() == nil) {
                                    
                                    alert = true
                                    
                                } else {
                                    
                                    self.signIn(email: (session.currentUser?.email)! as String, password: (session.currentUser?.getStoredPassword())! as String)
                                }
                            }
                                
                        }) {

                            Image(systemName: biometricsEnabled.faceIDAvailable() ? "faceid" : "touchid")
                        }
                        .padding(.trailing)
                        .alert(isPresented: $alert) {
                            
                            Alert(title: Text("Authentication Failed"), message: Text("Please sign in using your email and password"), dismissButton: .default(Text("OK")))
                        }
                    }
                }
                
                FaceBookLoginView(viewRouter: viewRouter).frame(height: 40).padding(.horizontal)
                
                ButtonOne(text: "S I G N  U P", color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), action: {
                    self.viewRouter.viewRouter = "Sign Up"
                    
                })
                .padding()
                
            }.padding()
        }
    }


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            SignInView(viewRouter: ViewRouter()).environmentObject(FirebaseSession())
        } else {
            // Fallback on earlier versions
        }
    }
}
