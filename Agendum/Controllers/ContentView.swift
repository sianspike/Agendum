//
//  ContentView.swift
//  Agendum
//
//  Created by Sian Pike on 05/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @EnvironmentObject var session: FirebaseSession
    @ObservedObject var viewRouter: ViewRouter
    
    func getUser() {
        session.listen()
    }
    
    func switchViews() -> AnyView {
        switch viewRouter.viewRouter {
        case "Dashboard":
            return AnyView(Dashboard(viewRouter: viewRouter))
        case "Focus":
            return AnyView(FocusView(viewRouter: viewRouter))
        case "All Items":
            return AnyView(AllItemsView(viewRouter: viewRouter))
        case "Friends":
            return AnyView(FriendView(viewRouter: viewRouter))
        case "Settings":
            return AnyView(SettingsView(viewRouter: viewRouter))
        case "Add Item":
            return AnyView(AddItemView())
        default:
            return AnyView(SignInView(viewRouter: viewRouter))
        }
    }
    
    var body: some View {

        Group {
            
            if(session.loggedInUser != nil) {

                switchViews()
                
                HomeView(viewRouter: viewRouter)

            } else {

                if (viewRouter.viewRouter == "Sign In" || viewRouter.viewRouter == "Dashboard") {
                    SignInView(viewRouter: viewRouter)
                } else if (viewRouter.viewRouter == "Sign Up") {
                    SignUpView(viewRouter: viewRouter)
                }
            }
        }.onAppear(perform: getUser)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewRouter: ViewRouter()).environmentObject(FirebaseSession())
    }
}
