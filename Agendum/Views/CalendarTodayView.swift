//
//  CalendarTodayView.swift
//  Agendum
//
//  Created by Sian Pike on 08/07/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI
import KVKCalendar
import EventKit
import EventKitUI

struct CalendarTodayView: UIViewRepresentable {
    
    @EnvironmentObject var session: FirebaseSession
    
    var calendarDayView: CalendarView = {
        
        var selected = UserDefaults().data(forKey: "selectedCalendars")
        var calendars: Set<String> = []
        
        func getSystemCalendars() -> Set<String> {
            
            //selected is nil (probabaly the selecting calendars bug, hard code)
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
        style.headerScroll.isHiddenSubview = true
        style.headerScroll.heightHeaderWeek = 0
        style.headerScroll.heightSubviewHeader = 0
        style.locale = Locale.current
        style.timezone = TimeZone.current
        style.allDay.isPinned = true
        style.timeline.startFromFirstEvent = false
        style.systemCalendars = getSystemCalendars()
        
        return CalendarView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 470), style: style)
    }()
    
    func makeUIView(context: UIViewRepresentableContext<CalendarTodayView>) -> CalendarView {

        calendarDayView.dataSource = context.coordinator
        calendarDayView.delegate = context.coordinator

        calendarDayView.reloadData()
        
        let test = CalendarAvailability()
        test.getAvailabilityBetween(startDate: Date().startOfDay!, endDate: Date().endOfDay!)

        return calendarDayView
    }
    
    func updateUIView(_ uiView: CalendarView, context: UIViewRepresentableContext<CalendarTodayView>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        
        Coordinator(self)
    }
    
    // MARK: Calendar DataSource and Delegate
    class Coordinator: NSObject, CalendarDataSource, CalendarDelegate {
        
        private let view: CalendarTodayView
        var events = [Event]()
        
        init(_ view: CalendarTodayView) {
        
            self.view = view
            
            super.init()
            
            loadEvents { (events) in
                
                self.events = events
                view.calendarDayView.reloadData()
            }
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
            
            let vc = UIHostingController(rootView: ItemDetailView(item: currentItem!))
            
            view.calendarDayView.findViewController()?.present(vc, animated: true)
        }
        
        func loadEvents(completion: ([Event]) -> Void) {
            
            var events = [Event]()
            let items = self.view.session.loggedInUser!.items
            
            for item in items {
                
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

extension UIViewController {
    
  func presentInFullScreen(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
    
    viewController.modalPresentationStyle = .fullScreen
    
    present(viewController, animated: animated, completion: completion)
  }
}

extension UIView {
    
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}
