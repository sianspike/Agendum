//
//  TextFieldWithBottomBorder.swift
//  Agendum
//
//  Created by Sian Pike on 14/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct TextFieldWithBottomBorder: View {
    @State var text: String = ""
    private var placeholder = ""

    init(placeholder: String, text: String) {
            self.placeholder = placeholder
            self.text = text
    }

    var body: some View {
        VStack() {
            TextField(placeholder, text: $text)
                .multilineTextAlignment(TextAlignment.center)
                .font(Font.custom("Montserrat-Regular", size: 20))
                HorizontalLineShape
                    .HorizontalLine(color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), height: 3, width: .infinity)
        }.padding()
    }
}

struct TextFieldWithBottomLine_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldWithBottomBorder(placeholder: "My placeholder", text: "Input")
    }
}
