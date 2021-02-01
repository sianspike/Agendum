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
 
    let store = EKEventStore()
    var selected = UserDefaults().data(forKey: "selectedCalendars")
    var session: FirebaseSession
    
    init(session: FirebaseSession) {
        
        self.session = session
    }
    
    func getEventsBetween(startDate: Date, endDate: Date) -> [EKEvent]? {
        
        let predicate = store.predicateForEvents(withStart: startDate, end: endDate, calendars: getSystemCalendars())
        
        return store.events(matching: predicate)
    }
    
    func getAvailabilityBetween(startDate: Date, endDate: Date) {
        
        let events = getEventsBetween(startDate: startDate, endDate: endDate)
        var intervals: [String: TimeInterval] = [:]
        
        if (events != nil) {
            
            //start date -> start of event
            let startToFirst = events![0].startDate.timeIntervalSince(startDate)
            intervals["StartDateToFirstEvent"] = startToFirst
        
            //end of event -> start of event
            for i in 0...(events!.count - 2) {
                
                intervals["Event\(i)ToEvent\(i + 1)"] = events![i + 1].startDate.timeIntervalSince(events![i].endDate)
            }
            
            //end of event -> end date
            let lastToEnd = endDate.timeIntervalSince(events![events!.count - 1].endDate)
            intervals["LastEventToEndDate"] = lastToEnd
            
        } else {
            
            //start date -> end date
            let startToEnd = endDate.timeIntervalSince(startDate)
            intervals["StartDateToEndDate"] = startToEnd
        }
        
        let suggestions = generateSuggestions(intervals: intervals, exclude: events ?? [])
        
        refineSuggestions(suggestions: suggestions)
    }
    
    func generateSuggestions(intervals: [String:TimeInterval], exclude: [EKEvent]) -> [String:[Item]] {
        
        var items = session.loggedInUser?.items
        var possibleTasks: [String:[Item]] = [:]
        
        for event in exclude {
            
            for i in 0...(items!.count - 2) {
                
                if (event.title == items![i].getTitle()) {
                    
                    items!.remove(at: i)
                }
            }
        }
        
        for interval in intervals {
            
            var itemList: [Item] = []
            
            for item in items! {
                
                if (item.getDuration() != nil) {
                    
                    if (item.getDuration()! <= interval.value) {
                        
                        itemList.append(item)
                    }
                }
            }
            
            possibleTasks[interval.key] = itemList
        }
        
        return possibleTasks
    }
    
    func refineSuggestions(suggestions: [String:[Item]]) {
        
        var refinedSuggestions: [String: Item?] = [:]
        
        for suggestion in suggestions {
            
            var closestItem: Item? = nil
            
            if (!suggestion.value.isEmpty) {
                
                closestItem = suggestion.value[0]
                
                for item in suggestion.value {
                    
                    if (item.isDateSet() && closestItem!.isDateSet() && item.getDate()!.isLessThanDate(dateToCompare: closestItem!.getDate()!)) {
                        
                        closestItem = item
                    }
                }
            }
            
            refinedSuggestions[suggestion.key] = closestItem
        }
        
        //find a way to remove closest item from arrays once its been put into  refinedSuggestions
        
        print(refinedSuggestions)
    }
    
    func getSystemCalendars() -> [EKCalendar]? {
        
        var calendarList: [EKCalendar]? = []
        
        if (selected == nil) {
            
            let calendars = store.calendars(for: .event)
            
            for item in calendars {
                
                if (item.title == "Calendar") {
                    
                    calendarList?.append(item)
                }
            }
            
        } else {
            
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
        }
        
        return calendarList ?? []
    }
}
