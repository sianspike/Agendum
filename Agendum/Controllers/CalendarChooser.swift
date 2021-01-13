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

struct CalendarChooser: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var calendars: Set<EKCalendar>?
    let store: EKEventStore
    
    func makeCoordinator() -> Coordinator {
        
        return Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<CalendarChooser>) -> UINavigationController {
        
        let chooser = EKCalendarChooser(selectionStyle: .multiple, displayStyle: .allCalendars, entityType: .event, eventStore: store)
        chooser.selectedCalendars = calendars ?? []
        chooser.delegate = context.coordinator
        chooser.showsDoneButton = true
        chooser.showsCancelButton = true
        
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
            
            parent.presentationMode.wrappedValue.dismiss()
        }

        func calendarChooserDidCancel(_ calendarChooser: EKCalendarChooser) {
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
