//
//  AddFriendView.swift
//  Agendum
//
//  Created by Sian Pike on 18/01/2021.
//  Copyright © 2021 Sian Pike. All rights reserved.
//

import SwiftUI

struct AddFriendView: View {
    
    @ObservedObject var viewRouter: ViewRouter
    @EnvironmentObject var session: FirebaseSession
    @State private var email: String = ""
    
    var body: some View {

        VStack {
            
            ZStack(alignment: .leading) {
                
                Button(action: {
                    
                    self.viewRouter.viewRouter = "Friends"
                    
                }) {
                    
                    Image(uiImage: UIImage(named: "Icons/Back - black.png")!)
                        .renderingMode(.original)
                }.padding(.bottom)
                
                TextWithBottomBorder(text: "A d d  F r i e n d")
            }
            
            Spacer()
            
            VStack {
                
                TextField("E m a i l", text: $email)
                    .multilineTextAlignment(TextAlignment.center)
                    .font(Font.custom("Montserrat-Regular", size: 20))
                HorizontalLineShape
                    .HorizontalLine(color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), height: 3, width: .infinity)
                
            }.padding()
            
            Spacer()
            
            ButtonOne(text: "S u b m i t", color: Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0), action: {
                
                session.findUser(email: $email.wrappedValue)
                session.addUser()
                session.retrieveFollowing()
                viewRouter.viewRouter = "Friends"
            })
            .padding()
        }
    }
}

struct AddFriendView_Previews: PreviewProvider {
    static var previews: some View {
        AddFriendView(viewRouter: ViewRouter())
    }
}
