//
//  CalendarMonthView.swift
//  Agendum
//
//  Created by Sian Pike on 08/07/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI
import KVKCalendar

struct CalendarMonthView: UIViewRepresentable {
    
    @EnvironmentObject var session: FirebaseSession
    
    var calendarMonthView: CalendarView = {
        var style = Style()
        style.defaultType = .month
        style.timeHourSystem = .twentyFourHour
        style.headerScroll.isScrollEnabled = false
        style.headerScroll.isHiddenTitleDate = true
        style.headerScroll.isHiddenCornerTitleDate = true
        style.headerScroll.heightHeaderWeek = 0
        style.headerScroll.heightTitleDate = 0
        style.event.isEnableMoveEvent = true
        style.locale = Locale.current
        style.timezone = TimeZone.current
        
        return CalendarView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 470), style: style)
    }()
    
    func makeUIView(context: Context) -> CalendarView {

            calendarMonthView.dataSource = context.coordinator
            calendarMonthView.delegate = context.coordinator

            calendarMonthView.reloadData()

            return calendarMonthView
    }
    
    func updateUIView(_ uiView: CalendarView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        
        Coordinator(self)
    }
    
    // MARK: Calendar DataSource and Delegate
    class Coordinator: NSObject, CalendarDataSource, CalendarDelegate {
        
        private let view: CalendarMonthView
        var events = [Event]()
        
        init(_ view: CalendarMonthView) {
            
            self.view = view
            
            super.init()
            
            loadEvents { (events) in
                
                self.events = events
                self.view.calendarMonthView.reloadData()
            }
        }
        
        func eventsForCalendar() -> [Event] {
            
            return events
        }
        
        func willDisplayDate(_ date: Date?, events: [Event]) -> DateStyle? {
            
            return nil
        }
        
        func loadEvents(completion: ([Event]) -> Void) {
            
            var events = [Event]()
            let models = self.view.session.loggedInUser!.items
            
            for item in models {
                
                if (item.isDateSet()) {
                    
                    var event = Event()
                    event.id = item.id
                    event.start = item.getDate()! as Date // start date event
                    event.end = item.getDate()!.addingTimeInterval(10000) as Date// end date event
                    event.color = EventColor(UIColor(red: 0.6, green: 0.8, blue: 1, alpha: 1))
                    event.backgroundColor = UIColor(red: 0.6, green: 0.8, blue: 1, alpha: 1)
                    //event.isAllDay = item.allDay
                    //event.isContainsFile = !item.files.isEmpty
                    
                    // Add text event (title, info, location, time)
                    //if item.allDay {
                    //    event.text = "\(model.title)"
                    //} else {
                    event.text = "\(item.getTitle())"
                    //}
                    
                    events.append(event)
                }
            }
            
            completion(events)
        }
    }
}
