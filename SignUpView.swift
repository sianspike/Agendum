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
            Text("Sign Up")
                .font(Font.custom("Montserrat-Medium", size: 30))
                .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
            TextFieldWithBottomBorder(placeholder: "Username", text: username)
            TextFieldWithBottomBorder(placeholder: "Email", text: email)
            TextFieldWithBottomBorder(placeholder: "Password", text: password)
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Text("CREATE ACCOUNT")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(Font.custom("Monsterrat-Medium", size: 15))
                    .foregroundColor(.black)
                    .padding(10)
                    .background(Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0))
            }.padding(.bottom)
            Button(action: {}) {
                Text("SIGN UP WITH FACEBOOK")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(Font.custom("Monsterrat-Medium", size: 15))
                    .foregroundColor(.black)
                    .padding(10)
                    .background(Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0))
            }
            Spacer()
            Button(action: {}) {
                Text("SIGN IN")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(Font.custom("Monsterrat-Medium", size: 15))
                    .foregroundColor(.black)
                    .padding(10)
                    .background(Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0))
            }
        }.padding()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
