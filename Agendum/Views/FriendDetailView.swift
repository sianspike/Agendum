//
//  FriendDetailView.swift
//  Agendum
//
//  Created by Sian Pike on 22/01/2021.
//  Copyright © 2021 Sian Pike. All rights reserved.
//

import SwiftUI

struct FriendDetailView: View {
    
    @EnvironmentObject var session: FirebaseSession
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var email: String
    var progress: Double
    
    var body: some View {
        
        VStack {
            
            TextWithBottomBorder(text: "\(email)")
            
            Text("\(Int(progress)) points")
                .foregroundColor(Color(red: 0.59, green: 0.76, blue: 0.96, opacity: 1.0))
                .font(Font.custom("Montserrat-Medium", size: 20))
            
            Spacer()
            
            TextWithBottomBorder(text: "R e c e n t  A c t i v i t y")
            
            Text("Recent activity")
            
            Spacer()
            
            ButtonOne(text: "D E L E T E", color: Color(red: 0.59, green: 0.76, blue: 0.96, opacity: 1.0), action: {
                
                session.unfollowUser(email: email)
                self.presentationMode.wrappedValue.dismiss()
            })
                .padding()
        }
    }
}
