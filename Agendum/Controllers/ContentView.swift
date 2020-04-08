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
    
    func getUser() {
        session.listen()
    }
    
    var body: some View {

        Group {
            
            if(session.loggedInUser != nil) {
                Dashboard(viewRouter: viewRouter)
                HomeView(viewRouter: viewRouter)
            } else {
                
                if (viewRouter.viewRouter == "Sign In") {
                    SignInView(viewRouter: viewRouter)
                } else if (viewRouter.viewRouter == "Sign Up") {
                    SignUpView(viewRouter: viewRouter)
                }
            }
            
//            if (viewRouter.viewRouter == "Dashboard") {
//                Dashboard(viewRouter: viewRouter)
//                HomeView(viewRouter: viewRouter)
//            } else if(viewRouter.viewRouter == "Sign In") {
//                SignInView(viewRouter: viewRouter)
//            } else if(viewRouter.viewRouter == "Sign Up"){
//                SignUpView(viewRouter: viewRouter)
//            } else {
//                SignInView(viewRouter: viewRouter)
//            }
        }.onAppear(perform: getUser)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewRouter: ViewRouter()).environmentObject(FirebaseSession())
    }
}
