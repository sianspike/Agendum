//
//  FocusPageOneView.swift
//  Agendum
//
//  Created by Sian Pike on 17/11/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct FocusPageOneView: View {
    
    @State private var timerLength = 0
    @State var timerTapped: Bool = false
    @State var beginTapped: Bool = false
    @State var timerInterval: TimeInterval? = 0
    
    var timeIntervals = ["25 minutes", "30 minutes", "50 minutes", "1 hour", "1.5 hours", "2 hours"]
    
    func convertToInterval(interval: Int) -> TimeInterval? {
        
        let minute: TimeInterval = 60.0
        let hour: TimeInterval = 60.0 * minute
        
        switch interval {
        
            case 0:
                timerInterval = minute * 25
            case 1:
                timerInterval = minute * 30
            case 2:
                timerInterval = minute * 50
            case 3:
                timerInterval = hour
            case 4:
                timerInterval = hour + (minute * 30)
            case 5:
                timerInterval = hour * 2
            default:
                timerInterval = nil
        }
        
        return timerInterval
    }
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                Spacer()
                
                FocusTimer(time: $timerInterval, counting: beginTapped)
                    .gesture(TapGesture()
                                .onEnded { _ in
                                    
                                    timerTapped.toggle()
                                })
                
                Spacer()
                
                ButtonOne(text: beginTapped ? "P A U S E" : "B E G I N", color: Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0), action: {
                    
                    beginTapped.toggle()
                    
                })
                .padding(.horizontal)
                
                Spacer()
                
                Text("C u r r e n t  T a s k")
                    .font(Font.custom("Monsterrat-Regular", size: 20))
                
                Spacer()
            }
            
            if (timerTapped) {
                
                VStack {
                    
                    if #available(iOS 14.0, *) {
//                        FocusPicker(timerLength: $timerLength, timeIntervals: timeIntervals)
//                            .onChange(of: timerLength){ newValue in
//                                timerInterval = convertToInterval(interval: newValue)
//                            }
                    } else {
                        // Fallback on earlier versions
                    }
                    
                    Button(action: {self.timerTapped = false}, label: {
                        
                        Text("Done")
                    })
                }
            }
        }

    }
}

struct FocusPageOneView_Previews: PreviewProvider {
    static var previews: some View {
        FocusPageOneView()
    }
}
