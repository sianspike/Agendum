//
//  CalendarWeekView.swift
//  Agendum
//
//  Created by Sian Pike on 08/07/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI
import KVKCalendar

struct CalendarWeekView: UIViewRepresentable {
    
    @EnvironmentObject var session: FirebaseSession
    
    var calendarWeekView: CalendarView = {
        var style = Style()
        style.startWeekDay = .monday
        style.timeHourSystem = .twentyFourHour
        style.headerScroll.isScrollEnabled = false
        style.event.isEnableMoveEvent = true
        style.locale = Locale.current
        style.timezone = TimeZone.current
        
        return CalendarView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 470), style: style)
    }()
    
    func makeUIView(context: UIViewRepresentableContext<CalendarWeekView>) -> CalendarView {

            calendarWeekView.dataSource = context.coordinator
            calendarWeekView.delegate = context.coordinator

            calendarWeekView.reloadData()

            return calendarWeekView
    }
    
    func updateUIView(_ uiView: CalendarView, context: UIViewRepresentableContext<CalendarWeekView>) {
        
        uiView.reloadData()
    }
    
    func makeCoordinator() -> Coordinator {
        
        Coordinator(self)
    }
    
    // MARK: Calendar DataSource and Delegate
    class Coordinator: NSObject, CalendarDataSource, CalendarDelegate {
        
        private let view: CalendarWeekView
        var events = [Event]()
        
        init(_ currentView: CalendarWeekView) {
            
            self.view = currentView
            
            super.init()
            
            loadEvents { (events) in
                
                self.events = events
                currentView.calendarWeekView.reloadData()
            }
        }
        
        func eventsForCalendar() -> [Event] {
            
            return events
        }
        
        func willDisplayDate(_ date: Date?, events: [Event]) -> DateStyle? {
            
            view.calendarWeekView.reloadData()
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
