//
//  ItemDetailView.swift
//  Agendum
//
//  Created by Sian Pike on 05/08/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI
import CareKitUI

struct ItemDetailView: View {
    
    let item: Item
    
    func convertDate(date: NSDate) -> String{
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss Z"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yy HH:mm"
        
        let str = dateFormatterGet.string(from: date as Date)
        
        if let date = dateFormatterGet.date(from: str) {
            print(dateFormatterPrint.string(from: date))
            
            return dateFormatterPrint.string(from: date)
            
        } else {
            
           return ("There was an error decoding the string")
        }
    }
    
    func convertToInterval(interval: TimeInterval) -> String? {
        
        var newInterval: String?
        
        switch interval {
        
            case 1800:
                newInterval = "30 minutes"
            case 3600:
                newInterval = "1 hour"
            case 5400:
                newInterval = "1.5 hours"
            case 7200:
                newInterval = "2 hours"
            default:
                newInterval = nil
        }
        
        return newInterval
    }
    
    var body: some View {
        
        VStack{
            
            TextWithBottomBorder(text: "\(item.getTitle())")
            
            if (item.isTask()) {
                
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 13)
                        .shadow(radius: 10)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    
                    Text("Task")
                        .font(Font.custom("Montserrat-SemiBold", size: 25))
                        .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
                    
                }.frame(height: 50)
            }
            
            if (item.isHabit()) {
                
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 13)
                        .shadow(radius: 10)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    
                    Text("Habit")
                        .font(Font.custom("Montserrat-SemiBold", size: 25))
                        .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
                    
                }.frame(height: 50)
            }
            
            if (item.isEvent()) {
                
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 13)
                        .shadow(radius: 10)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    
                    Text("Event lasting \(convertToInterval(interval: item.getDuration()!)!)")
                        .font(Font.custom("Montserrat-SemiBold", size: 25))
                        .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
                    
                }.frame(height: 50)
            }
            
            if (item.isDateSet()) {
                
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 13)
                        .shadow(radius: 10)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    
                    Text("Date: \(convertDate(date: item.getDate()!))")
                        .font(Font.custom("Montserrat-SemiBold", size: 25))
                        .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
                    
                }.frame(height: 50)
            }
            
            if (item.isReminderSet()) {
                
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 13)
                        .shadow(radius: 10)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    
                    Text("Reminder: \(convertDate(date: item.getReminderDate()!))")
                        .font(Font.custom("Montserrat-SemiBold", size: 25))
                        .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
                    
                }.frame(height: 50)
            }
            
            if (item.hasLabels()) {
                
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 13)
                        .shadow(radius: 10)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    
                    VStack{
                        Text("L a b e l s")
                            .font(Font.custom("Montserrat-SemiBold", size: 25))
                            .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
                        
                        List(item.getLabels(), id: \.self) { label in
                            
                            Text(label)
                                .font(Font.custom("Montserrat-SemiBold", size: 25))
                                .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
                        }
                    }
                    
                }.frame(height: 50)
            }
            
            Spacer()
            
            ButtonOne(text: "E d i t", color: Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0), action: {})
                .padding(.horizontal)
        }
    }
}
