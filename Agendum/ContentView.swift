//
//  ContentView.swift
//  Agendum
//
//  Created by Sian Pike on 05/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var session: FirebaseSession
    
    func getUser () {
        session.listen()
    }
    
    var body: some View {

        Group {
            if (session.session != nil) {
                Dashboard()
            } else {
                SignUpView()
            }
        }.onAppear(perform: getUser)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(FirebaseSession())
    }
}
