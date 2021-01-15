//
//  Item.swift
//  Agendum
//
//  Created by Sian Pike on 26/04/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import Foundation

class Item: Identifiable {
    
    var title: String
    private var task: Bool
    private var event: Bool
    private var habit: Bool
    private var dateToggle: Bool
    private var date: NSDate?
    private var reminderToggle: Bool
    private var reminder: NSDate?
    private var labels: Array<String>
    private var completed: Bool
    private var duration: TimeInterval?
    internal var id = UUID()
    
    init(title: String, task: Bool, habit: Bool, dateToggle: Bool, reminderToggle: Bool, completed: Bool, event: Bool) {
        self.title = title
        self.task = task
        self.habit = habit
        self.dateToggle = dateToggle
        self.reminderToggle = reminderToggle
        self.completed = completed
        self.event = event
        self.date = nil
        self.reminder = nil
        self.labels = []
        self.duration = nil
    }
    
    init(title: String, task: Bool, habit: Bool, dateToggle: Bool, date: NSDate?, reminderToggle: Bool, reminder: NSDate?, completed: Bool, labels: Array<String>, event: Bool, duration: TimeInterval?) {
        self.title = title
        self.task = task
        self.habit = habit
        self.dateToggle = dateToggle
        self.reminderToggle = reminderToggle
        self.completed = completed
        self.event = event
        self.date = date
        self.reminder = reminder
        self.labels = labels
        self.duration = duration
    }
    
    func getID() -> String {
        
        return self.id.uuidString
    }
    
    func isEvent() -> Bool {
        
        return self.event
    }
    
    func eventToggle() {
        
        self.event.toggle()
    }
    
    func setTitle(newTitle: String) {
        self.title = newTitle
    }
    
    func getTitle() -> String {
        return self.title
    }
    
    func toggleTask() {
        self.task.toggle()
    }
    
    func isTask() -> Bool {
        return self.task
    }
    
    func toggleHabit() {
        self.habit.toggle()
    }
    
    func isHabit() -> Bool {
        return self.habit
    }
    
    func toggleDate() {
        self.dateToggle.toggle()
    }
    
    func isDateSet() -> Bool {
        return self.dateToggle
    }
    
    func setDate(newDate: NSDate?) {
        self.date = newDate
    }
    
    func getDate() -> NSDate? {
        return self.date
    }
    
    func toggleReminder() {
        self.reminderToggle.toggle()
    }
    
    func isReminderSet() -> Bool {
        return self.reminderToggle
    }
    
    func setReminderDate(newDate: NSDate?) {
        self.reminder = newDate
    }
    
    func getReminderDate() -> NSDate? {
        return self.reminder
    }
    
    func addLabel(label: String) {
        self.labels.append(label)
    }
    
    func addLabels(labels: Array<String>) {
        self.labels.append(contentsOf: labels)
    }
    
    func removeLabel(label: String) {
        
        if(self.labels.contains(label)) {
            let index = self.labels.firstIndex(of: label)
            self.labels.remove(at: index!)
        }
    }
    
    func getLabels() -> Array<String>{
        return self.labels
    }
    
    func toggleCompleted() {
        self.completed.toggle()
    }
    
    func isCompleted() -> Bool {
        return self.completed
    }
    
    func setDuration(interval: TimeInterval) {
        
        self.duration = interval
    }
    
    func getDuration() -> TimeInterval? {
        
        return self.duration
    }
    
    func hasLabels() -> Bool {
        
        if (self.labels.isEmpty) {
            
            return false
        }
        
        return true
    }
}
