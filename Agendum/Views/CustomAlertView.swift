//
//  CustomAlertView.swift
//  Agendum
//
//  Created by Sian Pike on 23/12/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct CustomAlertView: View {
    
    @Binding var textEntered: String
    var alertTitle: String
    var placeholder: String
    var dismissText: String
    var action: () -> Void
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
            
            VStack {
                
                Text(alertTitle)
                    .font(.title)
                    .foregroundColor(.black)
                
                Divider()
                
                if (alertTitle == "Reauthenticate" || alertTitle == "Change Password") {
                    
                    SecureField(placeholder, text: $textEntered)
                        .padding(5)
                        .background(Color.gray.opacity(0.2))
                        .foregroundColor(.black)
                        .padding(.horizontal, 20)
                } else {
                    
                    TextField(placeholder, text: $textEntered)
                        .padding(5)
                        .background(Color.gray.opacity(0.2))
                        .foregroundColor(.black)
                        .padding(.horizontal, 20)
                        .autocapitalization(.none)
                }
                
                Divider()
                
                HStack {
                    
                    Button(action: action) {
                        Text(dismissText)
                    }
                }
                .padding(30)
                .padding(.horizontal, 40)
            }
        }.frame(width: 300, height: 200)
    }
}
