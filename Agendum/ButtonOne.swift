//
//  ButtonOne.swift
//  Agendum
//
//  Created by Sian Pike on 27/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct ButtonOne: View {
    
    private var text = ""
    private var color: Color = .black
    private var action: () -> Void

    init(text: String, color: Color, action: @escaping () -> Void) {
        
        self.text = text
        self.color = color
        self.action = action
    }
    
    var body: some View {
        
        Button(action: action) {
            Text(text)
                .frame(minWidth: 0, maxWidth: .infinity)
                .font(Font.custom("Monsterrat-Medium", size: 15))
                .foregroundColor(.black)
                .padding(10)
                .background(color)
        }.padding()
    }
}

struct ButtonOne_Previews: PreviewProvider {
    static var previews: some View {
        ButtonOne(text: "text", color: .red, action: {})
    }
}
