//
//  SettingsView.swift
//  Agendum
//
//  Created by Sian Pike on 27/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI
import EventKit

@available(iOS 14.0, *)
struct SettingsView: View {
    
    @EnvironmentObject var session: FirebaseSession
    @ObservedObject var viewRouter: ViewRouter
    @AppStorage("biometricsEnabled") var biometrics = false
    @AppStorage("calendarConnected") var calendar = false
    @State private var newEmail = ""
    @State private var newPassword = ""
    @State private var changeEmailShowing = false
    @State private var changePasswordShowing = false
    @State private var userAuthenticated = false
    @State private var authError = false
    @State private var bioFailed = false
    @State private var password = ""
    @State private var editingEmail = false
    @State private var editingPassword = false
    @State private var deletingAccount = false
    @State private var showingCalendarChooser = false
    private let store = EKEventStore()
    private let biometricsEnabled = Biometrics()
    @State var calendarSet: Set<EKCalendar>? = nil
    
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
                    
                    editingEmail = true
                    
                    if (biometrics) {
                        
                        let authenticated = biometricsEnabled.tryBiometricAuthentication()
                        
                        if (authenticated) {
                            
                            changeEmailShowing = true
                        }
                        
                    } else {
                        
                        userAuthenticated = true
                        changeEmailShowing = true
                    }
                    
                    editingEmail = false
                })
                .padding()
                .alert(isPresented: $authError) {
                    
                    Alert(title: Text("Error"), message: Text("Authentication Failed"), dismissButton: .default(Text("OK")))
                }
            
                ButtonOne(text: "C H A N G E  P A S S W O R D", color: Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0), action: {
                    
                    editingPassword = true
                    
                    if (biometrics) {
                        
                        let authenticated = biometricsEnabled.tryBiometricAuthentication()
                        
                        if (authenticated) {
                            
                            changePasswordShowing = true
                        }
                        
                    } else {
                        
                        userAuthenticated = true
                        changePasswordShowing = true
                    }
                    
                    editingPassword = false
                })
                .padding()
                .alert(isPresented: $authError) {
                    
                    Alert(title: Text("Error"), message: Text("Authentication Failed"), dismissButton: .default(Text("OK")))
                }
                
                if (calendar) {
                    
                    ButtonOne(text: "D I S C O N N E C T  C A L E N D A R", color: Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0), action: {
                        
                        calendar = false
                        //remove all non-app created events
                    })
                        .padding()
                    
                } else {
                    
                    ButtonOne(text: "C O N N E C T  C A L E N D A R", color: Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0), action: {
                        
                        showingCalendarChooser = true
                        
                        store.requestAccess(to: .event) { granted, error in
                            
                            if (granted) {
                                
                                calendar = true
                                calendarSet = Set(store.calendars(for: .event))
                                
                            } else {
                                
                                print("There was an error connecting your calendars: \(String(describing: error))")
                                calendar = false
                            }
                        }
                    })
                    .padding()
                    .sheet(isPresented: $showingCalendarChooser, onDismiss: {print($calendarSet)}) {
                        
                        //NEEDS TO BE TESTED - SWIFTUI BUG CAUSES IT TO DISSAPEAR IMMEDIATELY
                        CalendarChooser(calendars: $calendarSet, store: store)
                    }
                }
                
                HStack{
                    
        
                        Toggle(isOn: $biometrics) {
                            
                            Text("T o u c h  I D / F a c e  I D")
                                .font(Font.custom("Montserrat-Regular", size: 15))
                            
                        }
                        .padding()
                        .onChange(of: biometrics) { (value) in
                            
                            var success = false
                            
                            if (value) {
                                
                                success = biometricsEnabled.tryBiometricAuthentication()
                                
                                if (success) {
                                    
                                    biometrics = true
                                    
                                } else {
                                    
                                    bioFailed = true
                                }
                                
                            } else {
                                
                                biometrics = false
                            }
                        }
                        .alert(isPresented: $bioFailed) {
                            
                            Alert(title: Text("AuthenticationFailed"), message: Text("Unable to enable biometric authentication."), dismissButton: .default(Text("OK")))
                        }
                }
                
                Spacer()
                
                ButtonOne(text: "L O G  O U T", color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), action: {
                    
                    self.signOut()
                    
                }).padding()
                
                ButtonOne(text: "D E L E T E  A C C O U N T", color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), action: {
                    
                    deletingAccount = true
                    
                    if (biometrics) {
                        
                        let authenticated = biometricsEnabled.tryBiometricAuthentication()
                        
                        if (authenticated) {
                            
                            session.delete(password: (session.currentUser?.getStoredPassword())!)
                            biometrics = false
                        }
                        
                    } else {
                        
                        userAuthenticated = true
                        biometrics = false
                    }
                    
                    deletingAccount = false
                })
                .padding()
            }
            
            if (changeEmailShowing) {
                
                CustomAlertView(textEntered: $newEmail, alertTitle: "Change Email", placeholder: "New Email", dismissText: "Submit", action: {
                    
                    session.updateEmail(password: (session.currentUser?.email)!, newEmail: $newEmail.wrappedValue)
                    newEmail = ""
                    changeEmailShowing = false
                })
            }
            
            if(changePasswordShowing) {
                
                CustomAlertView(textEntered: $newPassword, alertTitle: "Change Password", placeholder: "New Password", dismissText: "Submit", action: {
                
                    session.updatePassword(oldPassword: (session.currentUser?.getStoredPassword())!, newPassword: $newPassword.wrappedValue)
                    
                    newPassword = ""
                    changePasswordShowing = false
                })
            }
            
            if (userAuthenticated) {
                
                CustomAlertView(textEntered: $password, alertTitle: "Reauthenticate", placeholder: "Password", dismissText: "OK", action: {
                    
                    if (editingPassword || editingEmail) {
                        
                        session.reauthenticate(password: $password.wrappedValue)
                        
                    } else if (deletingAccount) {
                        
                        session.delete(password: $password.wrappedValue)
                    }
                    
                    userAuthenticated = false
                })
            }
        }
    }
}
