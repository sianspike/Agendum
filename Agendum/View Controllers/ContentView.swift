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
    @ObservedObject var viewRouter: ViewRouter
    
    func getUser () {
        session.listen()
    }
    
    var body: some View {

        Group {
            
            if(viewRouter.viewRouter == "" && Auth.auth().currentUser != nil) {
                Dashboard(viewRouter: viewRouter)
            } else {
                SignInView(viewRouter: viewRouter)
            }
            
            if (viewRouter.viewRouter == "Dashboard" || viewRouter.viewRouter == "") {
                Dashboard(viewRouter: viewRouter)
            } else if(viewRouter.viewRouter == "Sign In") {
                SignInView(viewRouter: viewRouter)
            } else if(viewRouter.viewRouter == "Sign Up"){
                SignUpView(viewRouter: viewRouter)
            } else if(viewRouter.viewRouter == "Focus") {
                FocusView()
            }
            
        }.onAppear(perform: getUser)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewRouter: ViewRouter()).environmentObject(FirebaseSession(viewRouter: ViewRouter()))
    }
}
