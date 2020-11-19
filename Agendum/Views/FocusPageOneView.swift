//
//  FocusPageOneView.swift
//  Agendum
//
//  Created by Sian Pike on 17/11/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct FocusPageOneView: View {
    
    @State var beginTapped: Bool = false
    @State var breakTask: Bool = false
    @State var resetTimer: Bool = false
    @Binding var focusTimerInterval: TimeInterval?
    @Binding var breakTimerInterval: TimeInterval?
    @Binding var selectedTask: String
    @Binding var focusTimerLength: Int
    @Binding var breakTimerLength: Int
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                Spacer()
                
                FocusTimer(time: breakTask ? $breakTimerInterval : $focusTimerInterval, reset: $resetTimer, counting: beginTapped)
                
                Spacer()
                
                ButtonOne(text: beginTapped ? "P A U S E" : "B E G I N", color: Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0), action: {
                    
                    beginTapped.toggle()
                    
                })
                .padding(.horizontal)
                
                ButtonOne(text: breakTask ? "T A S K" : "B R E A K", color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), action: {
                    
                    breakTask.toggle()
                    beginTapped = false
                })
                .padding(.horizontal)
                
                ButtonOne(text: "R E S E T", color: Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0), action: {
                    
                    resetTimer = true
                    beginTapped = false
                    breakTask = false
                })
                    .padding(.horizontal)
                
                Spacer()
                
                Text("\(selectedTask)")
                    .font(Font.custom("Monsterrat-Regular", size: 20))
                
                Spacer()
            }
        }
    }
}
