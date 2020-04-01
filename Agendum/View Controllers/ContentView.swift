//
//  ContentView.swift
//  Agendum
//
//  Created by Sian Pike on 05/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI
import Firebase
import FBSDKLoginKit

struct ContentView: View {
    
    @EnvironmentObject var session: FirebaseSession    
    @ObservedObject var goToSignIn: GoToSignIn
    @ObservedObject var goToDashboard: GoToDashboard
    
    func getUser () {
        session.listen()
    }
    
    var body: some View {

        Group {
            
            if(Auth.auth().currentUser != nil) {
                Dashboard(goToSignIn: goToSignIn, goToDashboard: goToDashboard)
            } else {
                if (goToDashboard.goToDashboard) {
                    Dashboard(goToSignIn: goToSignIn, goToDashboard: goToDashboard)
                } else {
                    if(goToSignIn.goToSignIn) {
                        SignInView(goToSignIn: goToSignIn, goToDashboard: goToDashboard)
                    } else {
                        SignUpView(goToSignIn: goToSignIn, goToDashboard: goToDashboard)
                    }
                }
            }
        }.onAppear(perform: getUser)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(goToSignIn: GoToSignIn(), goToDashboard: GoToDashboard()).environmentObject(FirebaseSession(goToDashboard: GoToDashboard()))
    }
}
