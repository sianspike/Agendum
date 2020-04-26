//
//  TextFieldWithBottomBorder.swift
//  Agendum
//
//  Created by Sian Pike on 26/04/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct TextFieldWithBottomBorder: View {
    
    private var placeholder = ""
    @Binding private var text: String
    
    init(placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }
    
    var body: some View {
        
        VStack{
            
            TextField(placeholder, text: $text)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .font(Font.custom("Montserrat-Medium", size: 30))
            
            HorizontalLineShape
                .HorizontalLine(color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), height: 3, width: .infinity)
        }.padding()
    }
}

struct TextFieldWithBottomBorder_Previews: PreviewProvider {
    
    static var previews: some View {
      PreviewWrapper()
    }

    struct PreviewWrapper: View {
      @State(initialValue: "") var test: String

      var body: some View {
        TextFieldWithBottomBorder(placeholder: "Title", text: $test)
      }
    }
}
