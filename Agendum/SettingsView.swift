//
//  SettingsView.swift
//  Agendum
//
//  Created by Sian Pike on 27/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var touchID = false
    
    var body: some View {
        
        VStack {
            
            TextWithBottomBorder(text: "Settings")
            
            ButtonOne(text: "C H A N G E  E M A I L", color: Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0))
        
            ButtonOne(text: "C H A N G E  P A S S W O R D", color: Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0))
            
            ButtonOne(text: "C O N N E C T  C A L E N D A R", color: Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0))
            
            HStack{
                
                Toggle(isOn: $touchID) {
                    
                    Text("T o u c h  I D")
                        .font(Font.custom("Montserrat-Regular", size: 15))
 
                }.padding()
            }
            
            Spacer()
            
            ButtonOne(text: "D E L E T E  A C C O U N T", color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0))
            
            NavigationBar()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
