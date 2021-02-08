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
                    
                    ForEach(Array(CalendarAvailability(session: session).getAvailabilityBetween(startDate: Date().startOfDay!, endDate: Date().endOfDay!).keys), id: \.self) { key in
                        
                        let item = CalendarAvailability(session: session).getAvailabilityBetween(startDate: Date().startOfDay!, endDate: Date().endOfDay!)[key]!
                        
                        let regex = try! NSRegularExpression(pattern: "[0-9]")
                        
                        switch(key) {
                        
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
                            
                        case "Event\(regex)ToEvent\(regex)":
                            Text("Complete between your events.")
                                .bold()
                                .padding()
                            
                        default:
                            Text("")
                        }
                        
                        Text(item?.getTitle() ?? "Loading...")
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
