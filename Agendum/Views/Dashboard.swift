//
//  Dashboard.swift
//  Agendum
//
//  Created by Sian Pike on 14/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct Dashboard: View {
    
    @EnvironmentObject var session: FirebaseSession
    @ObservedObject var viewRouter: ViewRouter
    
    @State var progress: CGFloat = 69
    
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
            
            VStack(alignment: .leading) {
                
                TextWithBottomBorder(text: "T o d a y")
                
                ProgressBar(progress: $progress)
                
                TextWithBottomBorder(text: "A g e n d a")
                    .font(Font.custom("Montserrat-Regular", size: 25))
                
                Text("E v e n t s")
                    .font(Font.custom("Montserrat-SemiBold", size: 20))
                    .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
                    .multilineTextAlignment(.leading)
                    .padding()
            
                Text("R e m i n d e r s")
                    .font(Font.custom("Montserrat-SemiBold", size: 20))
                    .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
                    .multilineTextAlignment(.leading)
                    .padding()
                
                Text("T a s k s")
                    .font(Font.custom("Montserrat-SemiBold", size: 20))
                    .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
                    .multilineTextAlignment(.leading)
                    .padding()
                
                Text("S u g g e s t i o n s")
                    .font(Font.custom("Montserrat-SemiBold", size: 20))
                    .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
                    .multilineTextAlignment(.leading)
                    .padding()
                
                Spacer()
                
                Button(action: {self.signOut()}) {
                    Text("Log out")
                }

                NavigationBar(viewRouter: viewRouter)
            }
            
            FloatingAddButton()
        }
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard(viewRouter: ViewRouter())
    }
}
