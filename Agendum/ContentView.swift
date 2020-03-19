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
    
    func getUser () {
        session.listen()
    }
    
    var body: some View {

        Group {

            if (viewRouter.currentPage == "Sign Up") {
                SignUpView(viewRouter: viewRouter)
            } else if (viewRouter.currentPage == "Sign In") {
                SignInView(viewRouter: viewRouter)
            } else if (viewRouter.currentPage == "Dashboard") {
                Dashboard()
            }

        }.onAppear(perform: getUser)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewRouter: ViewRouter()).environmentObject(FirebaseSession())
    }
}
