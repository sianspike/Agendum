//
//  FocusPicker.swift
//  Agendum
//
//  Created by Sian Pike on 16/11/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct FocusPicker: View {
    
    @Binding var timerLength: Int
    var timeIntervals: [String]
    @Binding var done: Bool
    
    var body: some View {
        
        VStack {
            
            Picker(selection: $timerLength, label: Text("")) {
                
                ForEach(0 ..< timeIntervals.count) {
                    
                    Text(self.timeIntervals[$0]).tag($0)
                }
            }
            .frame(width: 300, height: 100)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            
            Button(action: {done = false}, label: {
                
                Text("Done")
            })
            .padding(.vertical)
        }
        .background(Color(.white))
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        .cornerRadius(10)
    }
}
