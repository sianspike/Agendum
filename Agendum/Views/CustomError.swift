//
//  CustomAlertView.swift
//  Agendum
//
//  Created by Sian Pike on 23/12/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct CustomErrow: View {
    
    var alertTitle: String
    var dismissText: String
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
            
            VStack {
                
                Text(alertTitle)
                    .font(.title)
                    .foregroundColor(.black)
                
                Divider()
                    
                
                HStack {
                    
                    Button(action: {}) {
                        Text(dismissText)
                    }
                }
                .padding(30)
                .padding(.horizontal, 40)
            }
        }.frame(width: 300, height: 200)
    }
}
