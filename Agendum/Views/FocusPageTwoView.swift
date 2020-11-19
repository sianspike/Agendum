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
    @Binding var focusTimerInterval: TimeInterval?
    @Binding var breakTimerInterval: TimeInterval?
    @Binding var selectedTask: String
    var timeIntervals = ["5 minutes", "10 minutes", "20 minutes", "25 minutes", "30 minutes", "50 minutes", "1 hour", "1.5 hours", "2 hours"]
    
    func convertToInterval(interval: Int) -> TimeInterval? {
        
        let minute: TimeInterval = 60.0
        let hour: TimeInterval = 60.0 * minute
        var newInterval: TimeInterval? = 0
        
        switch interval {
        
        case 0:
            newInterval = minute * 5
        case 1:
            newInterval = minute * 10
        case 2:
            newInterval = minute * 20
        case 3:
            newInterval = minute * 25
        case 4:
            newInterval = minute * 30
        case 5:
            newInterval = minute * 50
        case 6:
            newInterval = hour
        case 7:
            newInterval = hour + (minute * 30)
        case 8:
            newInterval = hour * 2
        default:
            newInterval = nil
        }
        
        return newInterval
    }
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                Spacer()
                
                HStack {
                    
                    Text("Focus Time")
                        .padding(.leading)
                    Spacer()
                    Text(timeIntervals[focusTimerLength])
                        .padding(.trailing)
                }
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                                
                            focusTimeTapped.toggle()
                        })
                
                HorizontalLineShape.HorizontalLine(color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), height: 3, width: .infinity)
                    .padding(.horizontal)
                
                Spacer()
                
                HStack {
                    
                    Text("Break Time")
                        .padding(.leading)
                    Spacer()
                    Text(timeIntervals[breakTimerLength])
                        .padding(.trailing)
                }
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                                
                            breakTimeTapped.toggle()
                        })
                
                HorizontalLineShape.HorizontalLine(color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), height: 3, width: .infinity)
                    .padding(.horizontal)
                
                Spacer()
                
                Text("T a s k s")
                    .font(Font.custom("Montserrat-Bold", size: 20))
                    .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
                    .padding(.vertical)
                
                ScrollView {
                    
                    ForEach(session.loggedInUser!.items, id: \.title) { item in
                        
                        if (!item.isCompleted()) {
                            
                            Text(item.getTitle())
                                .padding(.vertical, 2)
                                .frame(width: UIScreen.main.bounds.width)
                                .font(Font.custom("Montserrat-Regular", size: 15))
                                .onTapGesture {

                                    selectedTask = item.getTitle()
                                }
                                .background(selectedTask.elementsEqual(item.getTitle()) ? Color.init(red: 0.6, green: 0.9, blue: 1.0) : Color.white)
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width, height: 300)
            }
            .padding(.horizontal)
            
            if (focusTimeTapped) {
                
                VStack {
                    
                    if #available(iOS 14.0, *) {
                        
                        FocusPicker(timerLength: $focusTimerLength, timeIntervals: timeIntervals, done: $focusTimeTapped)
                            .onChange(of: focusTimerLength) { newValue in
                                
                                focusTimerInterval = convertToInterval(interval: newValue)
                            }
                        
                    } else {
                        // Fallback on earlier versions
                    }
                }
                
            } else if (breakTimeTapped) {
                
                VStack {
                    
                    if #available(iOS 14.0, *) {
                        
                        FocusPicker(timerLength: $breakTimerLength, timeIntervals: timeIntervals, done: $breakTimeTapped)
                            .onChange(of: breakTimerLength) { newValue in
                                
                                breakTimerInterval = convertToInterval(interval: newValue)
                            }
                        
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}
