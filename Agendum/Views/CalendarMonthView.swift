//
//  CalendarMonthView.swift
//  Agendum
//
//  Created by Sian Pike on 08/07/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI
import KVKCalendar
import EventKit

struct CalendarMonthView: UIViewRepresentable {
    
    @EnvironmentObject var session: FirebaseSession
    
    var selected = UserDefaults().data(forKey: "selectedCalendars")
    @State var calendars: Set<String> = []
    
    var calendarMonthView: CalendarView = {
        
        var selected = UserDefaults().data(forKey: "selectedCalendars")
        var calendars: Set<String> = []
        
        func getSystemCalendars() -> Set<String> {
            
            if selected != nil {
                
                var base64encodedstring = String(bytes: selected!, encoding: .utf8)
                base64encodedstring = base64encodedstring!.replacingOccurrences(of: "[", with: "")
                base64encodedstring = base64encodedstring!.replacingOccurrences(of: "]", with: "")
                base64encodedstring = base64encodedstring!.replacingOccurrences(of: "\"", with: "")
                
                let calendarArray: [String] = base64encodedstring!.components(separatedBy: ",")
                
                for calendar in calendarArray {

                    calendars.insert(calendar)
                }
            }
            
            return calendars
        }
        
        var style = Style()
        style.defaultType = .month
        style.timeSystem = .twentyFour
        style.headerScroll.isScrollEnabled = false
        style.headerScroll.isHiddenSubview = true
        style.headerScroll.heightHeaderWeek = 0
        style.headerScroll.heightSubviewHeader = 0
        style.locale = Locale.current
        style.timezone = TimeZone.current
        style.allDay.isPinned = true
        style.systemCalendars = getSystemCalendars()
        style.month.selectionMode = .single
        style.month.isHiddenTitle = true
        
        return CalendarView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 400), style: style)
    }()
    
    func getSystemCalendars() -> Set<String> {
        
        if selected != nil {
            
            var base64encodedstring = String(bytes: selected!, encoding: .utf8)
            base64encodedstring = base64encodedstring!.replacingOccurrences(of: "[", with: "")
            base64encodedstring = base64encodedstring!.replacingOccurrences(of: "]", with: "")
            base64encodedstring = base64encodedstring!.replacingOccurrences(of: "\"", with: "")
            
            let calendarArray: [String] = base64encodedstring!.components(separatedBy: ",")
            
            for calendar in calendarArray {

                calendars.insert(calendar)
            }
        }
        
        return calendars
    }
    
    func makeUIView(context: UIViewRepresentableContext<CalendarMonthView>) -> CalendarView {

            calendarMonthView.dataSource = context.coordinator
            calendarMonthView.delegate = context.coordinator

            calendarMonthView.reloadData()

            return calendarMonthView
    }
    
    func updateUIView(_ uiView: CalendarView, context: UIViewRepresentableContext<CalendarMonthView>) {
        
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
        
        func getEventsFromSystemCalendar(dates: [Date]?) -> [EKEvent] {
            
            let store = EKEventStore()
            var calendarList: [EKCalendar]? = []
            
            for cal in view.getSystemCalendars() {
                
                for systemCal in store.calendars(for: .event) {
                    
                    if (cal == systemCal.title) {
                        
                        calendarList!.append(systemCal)
                    }
                }
            }
            
            var predicate: NSPredicate? = nil
            
            if dates != nil {
                
                let endOfDay: TimeInterval = 86340
                predicate = store.predicateForEvents(withStart: dates![0], end: dates![0] + endOfDay, calendars: calendarList)
                
            } else {
                
                let date = Date()
                var startOfMonth: Date {
                    
                    let calendar = Calendar(identifier: .gregorian)
                    let components = calendar.dateComponents([.year, .month], from: date)

                    return  calendar.date(from: components)!
                }
                
                var endOfMonth: Date {
                    var components = DateComponents()
                    components.month = 1
                    components.second = -1
                    
                    return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
                }
                
                predicate = store.predicateForEvents(withStart: startOfMonth, end: endOfMonth, calendars: calendarList)
            }
         
            
            return store.events(matching: predicate!)
        }
        
        func eventsForCalendar(systemEvents: [EKEvent]) -> [Event] {
            
            let mappedEvents = systemEvents.compactMap({ $0.transform() })
            
            return events + mappedEvents
        }
        
        func didSelectEvent(_ event: Event, type: CalendarType, frame: CGRect?) {
            
            let items = self.view.session.loggedInUser!.items
            var currentItem: Item? = nil
            
            for item in items {
                
                if (item.getTitle() == event.text) {
                    
                    currentItem = item
                }
            }
            
            if (currentItem == nil) {
                
                let events = getEventsFromSystemCalendar(dates: nil)
                
                for iosEvent in events {
                    
                    if (iosEvent.title == event.text) {
                        
                        currentItem = Item(title: iosEvent.title, task: false, habit: false, dateToggle: true, date: iosEvent.startDate as NSDate?, reminderToggle: false, reminder: nil, completed: false, labels: [], event: true, duration: iosEvent.endDate.timeIntervalSince(iosEvent.startDate))
                    }
                }
            }
            
            let vc = UIHostingController(rootView: ItemDetailView(item: currentItem!))
                
            view.calendarMonthView.findViewController()?.present(vc, animated: true)
        }
        
        func convertDate(date: NSDate) -> String {
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss Z"

            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "dd/MM/yy"
            
            let str = dateFormatterGet.string(from: date as Date)
            
            if let date = dateFormatterGet.date(from: str) {
                
                return dateFormatterPrint.string(from: date)
                
            } else {
                
               return ("There was an error decoding the string")
            }
        }
        
        func didSelectDates(_ dates: [Date], type: CalendarType, frame: CGRect?) {
            
            let items = self.view.session.loggedInUser!.items
            var currentItems: [Item] = []
        
            //Items not from iOS Calendar
            for item in items {
                
                if (item.isDateSet()) {
                    
                    if (convertDate(date: item.getDate()!) == convertDate(date: dates[0] as NSDate)) {
                        
                        currentItems.append(item)
                    }
                }
            }
            
            //Items from iOS Calendar
            let events = getEventsFromSystemCalendar(dates: dates)
            
            for event in events {
                
                currentItems.append(Item(title: event.title, task: false, habit: false, dateToggle: true, date: event.startDate as NSDate?, reminderToggle: false, reminder: nil, completed: false, labels: [], event: true, duration: event.endDate.timeIntervalSince(event.startDate)))
            }
            
            
            let vc = UIHostingController(rootView: MonthDetailView(items: currentItems))
            
            view.calendarMonthView.findViewController()?.addChild(vc)
            vc.view.frame = CGRect(x: 0, y: 350, width: UIScreen.main.bounds.width, height: 120)
            view.calendarMonthView.addSubview(vc.view)
            vc.didMove(toParent: view.calendarMonthView.findViewController())
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
                    event.text = "\(item.getTitle())"
                    events.append(event)
                }
            }
            
            completion(events)
        }
    }
}

