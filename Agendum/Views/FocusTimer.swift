//
//  Timer.swift
//  Agendum
//
//  Created by Sian Pike on 24/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI
import Combine

struct FocusTimer: View {
    
    @Binding var time: TimeInterval?
    @Binding var reset: Bool
    var counting: Bool
    @State var originalTime: TimeInterval? = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func convertToString(time: TimeInterval) -> String {
        
        let calendar = Calendar.current
        let date = Date(timeIntervalSince1970: time)
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        
        return "\((hour - 1).description):\(minute.description):\(second.description)"
    }
        
    var body: some View {
        
        ZStack{
            
            Circle()
                .overlay(Circle()
                    .stroke(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0), lineWidth: 3))
                    .foregroundColor(Color.clear)
                .frame(width: 250, height: 250)
            Text(convertToString(time: time!))
                .font(Font.custom("Montserrat-Bold", size: 30))
                .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
                .onAppear(perform: {
                    
                    originalTime = time
                })
                .onReceive(timer) { _ in
                    
                    if (time! > 0 && counting) {

                        time! -= 1
                    }
                    
                    if (reset) {
                        
                        time = originalTime
                        reset = false
                    }
                }
        }
    }
}
