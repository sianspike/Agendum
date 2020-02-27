//
//  SignUpView.swift
//  Agendum
//
//  Created by Sian Pike on 07/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            Text("S i g n  U p")
                .font(Font.custom("Montserrat-Medium", size: 30))
                .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
            
            TextFieldWithBottomBorder(placeholder: "Username", text: username)
            
            TextFieldWithBottomBorder(placeholder: "Email", text: email)
            
            TextFieldWithBottomBorder(placeholder: "Password", text: password)
            
            ButtonOne(text: "C R E A T E  A C C O U N T", color: Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0))
                .padding(.bottom)
            
            ButtonOne(text: "S I G N  U P  W I T H  F A C E B O O K", color: Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0))
            
            Spacer()
            
            ButtonOne(text: "S I G N  I N", color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0))
            
        }.padding()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
