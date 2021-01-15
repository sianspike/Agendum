//
//  CalendarWeekView.swift
//  Agendum
//
//  Created by Sian Pike on 08/07/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI
import KVKCalendar
import EventKit

struct CalendarWeekView: UIViewRepresentable {
    
    @EnvironmentObject var session: FirebaseSession
    
    var calendarWeekView: CalendarView = {
        
        var selected = UserDefaults().data(forKey: "selectedCalendars")
        var calendars: Set<String> = []
        
        func getSystemCalendars() -> Set<String> {
            
            var base64encodedstring = String(bytes: selected!, encoding: .utf8)
            base64encodedstring = base64encodedstring!.replacingOccurrences(of: "[", with: "")
            base64encodedstring = base64encodedstring!.replacingOccurrences(of: "]", with: "")
            base64encodedstring = base64encodedstring!.replacingOccurrences(of: "\"", with: "")
            
            let calendarArray: [String] = base64encodedstring!.components(separatedBy: ",")
            
            for calendar in calendarArray {

                calendars.insert(calendar)
            }
            
            return calendars
        }
        
        var style = Style()
        style.startWeekDay = .monday
        style.timeSystem = .twentyFour
        style.headerScroll.isScrollEnabled = false
        style.locale = Locale.current
        style.timezone = TimeZone.current
        style.allDay.isPinned = true
        style.timeline.startFromFirstEvent = false
        style.systemCalendars = getSystemCalendars()
        style.headerScroll.heightHeaderWeek = 70
        
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
        
        init(_ view: CalendarWeekView) {
            
            self.view = view
            
            super.init()
            
            loadEvents { (events) in
                
                self.events = events
                self.view.calendarWeekView.reloadData()
            }
        }
        
        func eventsForCalendar(systemEvents: [EKEvent]) -> [Event] {
            
            let mappedEvents = systemEvents.compactMap({ $0.transform() })
            
            return events + mappedEvents
        }
        
        func willDisplayDate(_ date: Date?, events: [Event]) {
            
            self.view.calendarWeekView.reloadData()
        }
        
        func didSelectEvent(_ event: Event, type: CalendarType, frame: CGRect?) {
            
            let items = self.view.session.loggedInUser!.items
            var currentItem: Item? = nil
            
            for item in items {
                
                if (item.getTitle() == event.text) {
                    
                    currentItem = item
                }
            }
            
            let vc = UIHostingController(rootView: ItemDetailView(item: currentItem!))
            
            view.calendarWeekView.findViewController()?.present(vc, animated: true)
        }
        
        func loadEvents(completion: ([Event]) -> Void) {
            
            var events = [Event]()
            let models = self.view.session.loggedInUser!.items
            
            for item in models {
                
                if (item.isDateSet()) {
                    
                    var event = Event(ID: item.getID())
                    event.start = item.getDate()! as Date
                    
                    if (item.getDuration() != nil) {
                        
                        event.end = item.getDate()!.addingTimeInterval(item.getDuration()!) as Date
                        
                    } else {
                        
                        event.isAllDay = true
                    }
                    
                    event.color = Event.Color(UIColor(red: 0.6, green: 0.8, blue: 1, alpha: 1))
                    event.backgroundColor = UIColor(red: 0.6, green: 0.8, blue: 1, alpha: 1)
                    
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

