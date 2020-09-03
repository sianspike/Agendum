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
        style.allDay.isPinned = true
        
        return CalendarView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 400), style: style)
    }()
    
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
        
        func eventsForCalendar() -> [Event] {
            
            return events
        }
        
        func willDisplayDate(_ date: Date?, events: [Event]) -> DateStyle? {
            
            return nil
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
        
        func didSelectDate(_ date: Date?, type: CalendarType, frame: CGRect?) {
            
            let items = self.view.session.loggedInUser!.items
            var currentItems: [Item] = []
        
            for item in items {
                
                if (item.isDateSet()) {
                    
                    if (convertDate(date: item.getDate()!) == convertDate(date: date! as NSDate)) {
                        
                        currentItems.append(item)
                    }
                }
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
                    
                    var event = Event()
                    event.id = item.id
                    event.start = item.getDate()! as Date
                    
                    if (item.getDuration() != nil) {
                        
                        event.end = item.getDate()!.addingTimeInterval(item.getDuration()!) as Date
                        
                    } else {
                        
                        event.isAllDay = true
                    }
                    
                    event.color = EventColor(UIColor(red: 0.6, green: 0.8, blue: 1, alpha: 1))
                    event.backgroundColor = UIColor(red: 0.6, green: 0.8, blue: 1, alpha: 1)
                    event.text = "\(item.getTitle())"
                    events.append(event)
                }
            }
            
            completion(events)
        }
    }
}

