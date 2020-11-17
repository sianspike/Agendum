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
    
    var body: some View {
        
        Picker(selection: $timerLength, label: Text("How long?")) {
            
            ForEach(0 ..< timeIntervals.count) {
                
                Text(self.timeIntervals[$0]).tag($0)
            }
        }
        .frame(width: 300, height: 100)
        .clipped()
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}
