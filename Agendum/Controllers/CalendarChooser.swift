//
//  CalendarChooser.swift
//  Agendum
//
//  Created by Sian Pike on 13/01/2021.
//  Copyright © 2021 Sian Pike. All rights reserved.
//

import Foundation
import SwiftUI
import EventKitUI

@available(iOS 14.0, *)
struct CalendarChooser: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var calendars: Set<EKCalendar>?
    let store: EKEventStore
    @AppStorage("selectedCalendars") var selected: Data = Data()
    @State var temp: EKCalendarChooser? = nil
    
    func makeCoordinator() -> Coordinator {
        
        return Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<CalendarChooser>) -> UINavigationController {
        
        let chooser = EKCalendarChooser(selectionStyle: .multiple, displayStyle: .allCalendars, entityType: .event, eventStore: store)
        chooser.selectedCalendars = calendars ?? []
        chooser.delegate = context.coordinator
        chooser.showsDoneButton = true
        chooser.showsCancelButton = true
        
        temp = chooser
        
        return UINavigationController(rootViewController: chooser)
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: UIViewControllerRepresentableContext<CalendarChooser>) {
        
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, EKCalendarChooserDelegate {
        
        var parent: CalendarChooser

        init(_ parent: CalendarChooser) {
            
            self.parent = parent
        }

        func calendarChooserDidFinish(_ calendarChooser: EKCalendarChooser) {
            
            parent.calendars = calendarChooser.selectedCalendars
            
            var calendarArray: Array<String> = []
            
            for calendar in parent.temp!.selectedCalendars {
                
                calendarArray.append(calendar.title)
            
            }
            
            //remove later
            if (calendarArray.isEmpty) {
                
                calendarArray.append("Calendar")
            }
            
            let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: calendarArray, requiringSecureCoding: false)
            let base64String = encodedData!.base64EncodedString()
            let data = Data(base64Encoded: base64String)
            parent.selected = data!
            
            parent.presentationMode.wrappedValue.dismiss()
        }

        func calendarChooserDidCancel(_ calendarChooser: EKCalendarChooser) {
            
            var calendarArray: Array<String> = []
            
            for calendar in parent.temp!.selectedCalendars {
                
                calendarArray.append(calendar.title)
            
            }
            
            //remove later
            if (calendarArray.isEmpty) {
                
                calendarArray.append("Calendar")
            }
            
            let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: calendarArray, requiringSecureCoding: false)
            let base64String = encodedData!.base64EncodedString()
            let data = Data(base64Encoded: base64String)
            parent.selected = data!
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
