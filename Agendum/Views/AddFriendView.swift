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
    @State var email: String = ""
    
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
            
            TextFieldWithBottomBorder(placeholder: "F r i e n d  E m a i l", text: $email)
            
            Spacer()
            
            ButtonOne(text: "S u b m i t", color: Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0), action: {
                
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
