//
//  Notifications.swift
//  Agendum
//
//  Created by Sian Pike on 25/01/2021.
//  Copyright © 2021 Sian Pike. All rights reserved.
//

import Foundation
import UserNotifications

struct Notifications {
    
    var title: String
    var reminderDate: Date
    
    func requestPermissions() {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            
            if success {
                
                print("Notification permissions success.")
                
            } else if let error = error {
                
                print(error.localizedDescription)
            }
        }
    }
    
    func generateNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "\(title) is due!"
        content.subtitle = "You set a reminder for today."
        content.sound = UNNotificationSound.default
        
        let timeBetweenNowAndReminder = reminderDate.timeIntervalSince(Date())
        
        // Configure the recurring date.
        let nextTriggerDate = Calendar.current.date(byAdding: .minute, value: timeBetweenNowAndReminder.minutes, to: Date())!
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: nextTriggerDate)
           
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)

        print("notification triggered")
    }
}

extension TimeInterval {

    var minutes: Int {
        return (Int(self) / 60 ) % 60
    }
}
