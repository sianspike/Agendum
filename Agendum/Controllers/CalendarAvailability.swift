//
//  CalendarAvailability.swift
//  Agendum
//
//  Created by Sian Pike on 27/01/2021.
//  Copyright © 2021 Sian Pike. All rights reserved.
//

import Foundation
import EventKit

class CalendarAvailability {
    
    //get events
    //find gaps between events
 
    let store = EKEventStore()
    var selected = UserDefaults().data(forKey: "selectedCalendars")
    
    func getEventsBetween(startDate: Date, endDate: Date) -> [EKEvent]? {
        
        let predicate = store.predicateForEvents(withStart: startDate, end: endDate, calendars: getSystemCalendars())
        
        return store.events(matching: predicate)
    }
    
    func getAvailabilityBetween(startDate: Date, endDate: Date) {
        
        let events = getEventsBetween(startDate: startDate, endDate: endDate)
        var intervals: [TimeInterval] = []
        
        //start date -> end date
        let startToEnd = endDate.timeIntervalSince(startDate)
        intervals.append(startToEnd)
        
        //start date -> start of event
        let startToFirst = events![0].startDate.timeIntervalSince(startDate)
        intervals.append(startToFirst)
    
        //end of event -> start of event
        for i in 1...events!.count {
            
            intervals.append(events![i + 1].startDate.timeIntervalSince(events![i].endDate))
        }
        
        //end of event -> end date
        let lastToEnd = endDate.timeIntervalSince(events![events!.count].endDate)
        intervals.append(lastToEnd)
    }
    
    func getSystemCalendars() -> [EKCalendar]? {
        
        var calendarList: [EKCalendar]? = []
        var base64encodedstring = String(bytes: selected!, encoding: .utf8)
        base64encodedstring = base64encodedstring!.replacingOccurrences(of: "[", with: "")
        base64encodedstring = base64encodedstring!.replacingOccurrences(of: "]", with: "")
        base64encodedstring = base64encodedstring!.replacingOccurrences(of: "\"", with: "")
        
        let calendarArray: [String] = base64encodedstring!.components(separatedBy: ",")
        
        for calendar in calendarArray {
            
            for systemCal in store.calendars(for: .event) {
                
                if (calendar == systemCal.title) {
                    
                    calendarList!.append(systemCal)
                }
            }
        }
        
        return calendarList ?? []
    }
}
