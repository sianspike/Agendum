//
//  FloatingAddButton.swift
//  Agendum
//
//  Created by Sian Pike on 27/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct FloatingAddButton: View {
    var body: some View {
        
        VStack {
            
            HStack {
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Image(uiImage: UIImage(named: "Icons/Add.png")!)
                        .renderingMode(.original)
                        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
                        .padding()
                }
                
            }.frame(maxWidth: .infinity, alignment: .bottomTrailing)
            
        }.frame(maxHeight: 700, alignment: .bottomTrailing)
    }
}

struct FloatingAddButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingAddButton()
    }
}
