//
//  ResetPasswordView.swift
//  Agendum
//
//  Created by Sian Pike on 27/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @State var email: String = ""
    
    var body: some View {
        
        VStack{
            
//            TextFieldWithBottomBorder(placeholder: "Email", text: $email)
            
            ButtonOne(text: "R E S E T  P A S S W O R D", color: Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0), action: {})
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
