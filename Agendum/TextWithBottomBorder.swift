//
//  TextWithBottomBorder.swift
//  Agendum
//
//  Created by Sian Pike on 14/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct TextWithBottomBorder: View {
    private var text = ""
    
    init(text: String) {
        self.text = text
    }

    var body: some View {
        VStack() {
            Text(text)
                .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
                .multilineTextAlignment(TextAlignment.center)
                .font(Font.custom("Montserrat-Medium", size: 30))
                HorizontalLineShape
                    .HorizontalLine(color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), height: 3)
        }.padding()
    }
}


struct TextWithBottomBorder_Previews: PreviewProvider {
    static var previews: some View {
        TextWithBottomBorder(text: "Time")
    }
}
