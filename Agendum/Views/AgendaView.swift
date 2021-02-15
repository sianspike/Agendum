//
//  AgendaView.swift
//  Agendum
//
//  Created by Sian Pike on 31/05/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI
import CareKitUI

struct AgendaView: View {
    
    @EnvironmentObject var session: FirebaseSession
    @Environment(\.defaultMinListRowHeight) var minRowHeight
    var timeFrame: Int
    var currentItem: Item? = nil
    
    func deleteItems(at offsets: IndexSet) {
            
        session.loggedInUser?.items.remove(atOffsets: offsets)            
        print("deleted")
    }
    
    func timeFrameChooser() -> (Date, Date) {
        
        if (timeFrame == 0) {
            
            return (Date().startOfDay!, Date().endOfDay!)
            
        } else if (timeFrame == 1) {
            
            return (Date().startMondayOfWeek!, Date().endSundayOfWeek!)
            
        } else {
            
            return (Date().startOfMonth!, Date().endOfMonth!)
        }
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading) {

                    Text("E v e n t s")
                        .font(Font.custom("Montserrat-SemiBold", size: 20))
                        .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
                        .padding(.horizontal)
                    
                            
                    ForEach(self.session.loggedInUser?.items ?? [], id: \.title) { item in

                        ItemRow(item: item, isEvent: true, isReminder: false, isTask: false, timeFrame: self.timeFrame)
                            .padding(.horizontal)
                    }
  
                    Text("R e m i n d e r s")
                        .font(Font.custom("Montserrat-SemiBold", size: 20))
                        .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
                        .padding()
                    
                    ForEach(self.session.loggedInUser?.items ?? []) { item in

                        ItemRow(item: item, isEvent: false, isReminder: true, isTask: false, timeFrame: self.timeFrame)
                            .padding(.horizontal)
                        
                    }
                        
                    Text("T a s k s")
                        .font(Font.custom("Montserrat-SemiBold", size: 20))
                        .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
                        .padding()
                    
                    ForEach(self.session.loggedInUser?.items ?? []) { item in

                        ItemRow(item: item, isEvent: false, isReminder: false, isTask: true, timeFrame: self.timeFrame)
                            .padding(.horizontal)
                        
                    }
                    
                        
                    Text("S u g g e s t i o n s")
                        .font(Font.custom("Montserrat-SemiBold", size: 20))
                        .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
                        .padding()
                    
                    ForEach(Array(CalendarAvailability(session: session).getAvailabilityBetween(startDate: timeFrameChooser().0, endDate: timeFrameChooser().1)), id: \.key) { item in
                        
                        switch(item.key) {

                        case "StartDateToEndDate":
                            Text("Complete anytime today.")
                                .bold()
                                .padding()

                        case "LastEventToEndDate":
                            Text("Complete after your last event.")
                                .bold()
                                .padding()

                        case "StartDateToFirstEvent":
                            Text("Complete before your first event.")
                                .bold()
                                .padding()

                        default:
                            Text("Complete between event \(item.key[5]) and event \(item.key[13])")
                                .bold()
                                .padding()
                        }
                        
                        Text(item.value?.getTitle() ?? "Loading...")
                            .padding()
                    }
                    
                }.frame(width: geometry.size.width, alignment: .leading)
                
            }.frame(width: geometry.size.width, alignment: .leading)
        }
    }
}

struct AgendaView_Previews: PreviewProvider {
    static var previews: some View {
        AgendaView(timeFrame: 0)
    }
}

extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
