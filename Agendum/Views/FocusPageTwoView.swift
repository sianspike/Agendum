//
//  FocusPageTwoView.swift
//  Agendum
//
//  Created by Sian Pike on 18/11/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct FocusPageTwoView: View {
    
    @EnvironmentObject var session: FirebaseSession
    @State var focusTimeTapped: Bool = false
    @State var breakTimeTapped: Bool = false
    @State var focusTimerLength = 0
    @State var breakTimerLength = 0
    var focusTimeIntervals = ["25 minutes", "30 minutes", "50 minutes", "1 hour", "1.5 hours", "2 hours"]
    var breakTimeIntervals = ["5 minutes", "10 minutes", "20 minutes", "25 minutes", "30 minutes"]
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                Spacer()
                
                HStack {
                    
                    Text("Focus Time")
                    Spacer()
                    Text(focusTimeIntervals[focusTimerLength])
                }
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                                
                            focusTimeTapped.toggle()
                        })
                
                HorizontalLineShape.HorizontalLine(color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), height: 3, width: .infinity)
                
                Spacer()
                
                HStack {
                    
                    Text("Break Time")
                    Spacer()
                    Text(breakTimeIntervals[breakTimerLength])
                }
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                                
                            breakTimeTapped.toggle()
                        })
                
                HorizontalLineShape.HorizontalLine(color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), height: 3, width: .infinity)
                
                Spacer()
                
                Text("T a s k s")
                    .font(Font.custom("Montserrat-Bold", size: 20))
                    .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
                    .padding(.vertical)
                
                ForEach(session.loggedInUser!.items, id: \.title) { item in
                    
                    if (!item.isCompleted()) {
                        
                        Text(item.getTitle())
                            .font(Font.custom("Montserrat-Regular", size: 15))
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal)
            
            if (focusTimeTapped) {
                
                VStack {
                    
                    FocusPicker(timerLength: $focusTimerLength, timeIntervals: focusTimeIntervals, done: $focusTimeTapped)
                }
            } else if (breakTimeTapped) {
                
                VStack {
                    
                    FocusPicker(timerLength: $breakTimerLength, timeIntervals: breakTimeIntervals, done: $breakTimeTapped)

                    Button(action: {self.breakTimeTapped = false}, label: {
                        
                        Text("Done")
                    })
                }
            }
        }
    }
}

struct FocusPageTwoView_Previews: PreviewProvider {
    static var previews: some View {
        FocusPageTwoView()
    }
}
