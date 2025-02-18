//
//  CalendarView.swift
//  Agendum
//
//  Created by Sian Pike on 12/06/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI
import KVKCalendar

struct CalendarDisplayView: UIViewRepresentable {
    
    @EnvironmentObject var session: FirebaseSession
    @State var timeFrame: Int
    
    var calendarDayView: CalendarView = {
        var style = Style()
        style.startWeekDay = .monday
        style.timeHourSystem = .twentyFourHour
        style.headerScroll.isHiddenTitleDate = true
        style.headerScroll.isHiddenCornerTitleDate = true
        style.headerScroll.heightHeaderWeek = 0
        style.headerScroll.heightTitleDate = 0
        style.event.isEnableMoveEvent = true
        style.locale = Locale.current
        style.timezone = TimeZone.current
        
        return CalendarView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 470), style: style)
    }()
    
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
        
        if (timeFrame == 0) {

            calendarDayView.dataSource = context.coordinator
            calendarDayView.delegate = context.coordinator

            calendarDayView.reloadData()

            return calendarDayView

        } else if (timeFrame == 1) {

            calendarWeekView.dataSource = context.coordinator
            calendarWeekView.delegate = context.coordinator

            calendarWeekView.reloadData()

            return calendarWeekView

        } else if (timeFrame == 2) {

            calendarMonthView.dataSource = context.coordinator
            calendarMonthView.delegate = context.coordinator

            calendarMonthView.reloadData()

            return calendarMonthView
        }

        return calendarDayView
    }
    
    func updateUIView(_ uiView: CalendarView, context: Context) {
        
        
        
//        let views = [calendarDayView, calendarWeekView, calendarMonthView]
//
//        if (timeFrame == 0) {
//
//            calendarDayView.delegate = context.coordinator
//            calendarDayView.dataSource = context.coordinator
//            calendarDayView.reloadData()
//
//            uiView.delegate = calendarDayView.delegate
//            uiView.dataSource = calendarDayView.dataSource
//
//        } else if (timeFrame == 1) {
//
//            calendarWeekView.delegate = context.coordinator
//            calendarWeekView.dataSource = context.coordinator
//            calendarWeekView.reloadData()
//
//            uiView.delegate = calendarWeekView.delegate
//            uiView.dataSource = calendarWeekView.dataSource
//
//        } else if (timeFrame == 2) {
//
//            calendarMonthView.delegate = context.coordinator
//            calendarMonthView.dataSource = context.coordinator
//            calendarMonthView.reloadData()
//
//            uiView.delegate = calendarMonthView.delegate
//            uiView.dataSource = calendarMonthView.dataSource
//        }
//
//        uiView.addSubview(views[timeFrame])
//        uiView.reloadData()
    }
    
    func makeCoordinator() -> Coordinator {
        
        Coordinator(self)
    }
    
    // MARK: Calendar DataSource and Delegate
    class Coordinator: NSObject, CalendarDataSource, CalendarDelegate {
        
        private let view: CalendarDisplayView
        var events = [Event]()
        
        init(_ view: CalendarDisplayView) {
            
            self.view = view
            
            super.init()
            
            loadEvents { (events) in
                
                self.events = events

                if (self.view.timeFrame == 0) {

                    self.view.calendarDayView.reloadData()

                } else if (self.view.timeFrame == 1) {

                    self.view.calendarWeekView.reloadData()

                } else if (self.view.timeFrame == 2) {

                    self.view.calendarMonthView.reloadData()
                }
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
