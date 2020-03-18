//
//  FriendView.swift
//  Agendum
//
//  Created by Sian Pike on 27/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct FriendView: View {
    var body: some View {
        ZStack {
            
            VStack (alignment: .leading){
                
                TextWithBottomBorder(text: "F r i e n d s")
                
                Spacer()
                
                HorizontalLineShape
                    .HorizontalLine(color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), height: 3, width: .infinity)
                    .padding(.horizontal)
                
                HStack {
                    
                    Text("Y o u")
                        .font(Font.custom("Montserrat-Regular", size: 15))
                    
                    Spacer()
                    
                    Text("6 9")
                        .font(Font.custom("Montserrat-Regular", size: 15))
                    
                }.padding()
                
                NavigationBar()
            }
            
            FloatingAddButton()
                .frame(height: 550)
        }
    }
}

struct FriendView_Previews: PreviewProvider {
    static var previews: some View {
        FriendView()
    }
}
