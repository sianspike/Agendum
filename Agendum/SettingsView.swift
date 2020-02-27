//
//  SettingsView.swift
//  Agendum
//
//  Created by Sian Pike on 27/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var touchID = true
    
    var body: some View {
        
        VStack {
            
            TextWithBottomBorder(text: "Settings")
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Text("C H A N G E  E M A I L")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(Font.custom("Monsterrat-Medium", size: 15))
                    .foregroundColor(.black)
                    .padding(10)
                    .background(Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0))
            }.padding()
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Text("C H A N G E  P A S S W O R D")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(Font.custom("Monsterrat-Medium", size: 15))
                    .foregroundColor(.black)
                    .padding(10)
                    .background(Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0))
            }.padding()
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Text("C O N N E C T  C A L E N D A R")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(Font.custom("Monsterrat-Medium", size: 15))
                    .foregroundColor(.black)
                    .padding(10)
                    .background(Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0))
            }.padding()
            
            HStack{
                
                Toggle(isOn: $touchID) {
                    
                    Text("T o u c h  I D")
                        .font(Font.custom("Montserrat-Regular", size: 15))
 
                }.padding()
            }
            
            Spacer()
            
            Button(action: {}) {
                Text("D E L E T E  A C C O U N T")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(Font.custom("Monsterrat-Medium", size: 15))
                    .foregroundColor(.black)
                    .padding(10)
                    .background(Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0))
            }.padding()
            
            NavigationBar()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
