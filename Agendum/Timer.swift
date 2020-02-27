//
//  Timer.swift
//  Agendum
//
//  Created by Sian Pike on 24/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct Timer: View {
    var body: some View {
        
        ZStack{
            Circle()
                .overlay(Circle()
                    .stroke(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0), lineWidth: 3))
                    .foregroundColor(Color.clear)
                .frame(width: 250, height: 250)
            Text("25:00")
                .font(Font.custom("Montserrat-Bold", size: 30))
                .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
        }
    }
}

struct Timer_Previews: PreviewProvider {
    static var previews: some View {
        Timer()
    }
}
