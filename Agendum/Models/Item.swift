//
//  Item.swift
//  Agendum
//
//  Created by Sian Pike on 26/04/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import Foundation

class Item: Identifiable {
    
    private var title: String
    private var task: Bool
    private var habit: Bool
    private var dateToggle: Bool
    private var date: Date?
    private var reminderToggle: Bool
    private var reminder: Date?
    private var labels: Array<String>
    private var completed: Bool
    
    init(title: String, task: Bool, habit: Bool, dateToggle: Bool, reminderToggle: Bool, completed: Bool) {
        self.title = title
        self.task = task
        self.habit = habit
        self.dateToggle = dateToggle
        self.reminderToggle = reminderToggle
        self.completed = completed
        
        self.date = nil
        self.reminder = nil
        self.labels = []
    }
    
    init(title: String, task: Bool, habit: Bool, dateToggle: Bool, date: Date?, reminderToggle: Bool, reminder: Date?, completed: Bool, labels: Array<String>) {
        self.title = title
        self.task = task
        self.habit = habit
        self.dateToggle = dateToggle
        self.reminderToggle = reminderToggle
        self.completed = completed
        
        self.date = date
        self.reminder = reminder
        self.labels = labels
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
    
    func setDate(newDate: Date?) {
        self.date = newDate
    }
    
    func getDate() -> Date? {
        return self.date
    }
    
    func toggleReminder() {
        self.reminderToggle.toggle()
    }
    
    func isReminderSet() -> Bool {
        return self.reminderToggle
    }
    
    func setReminderDate(newDate: Date?) {
        self.reminder = newDate
    }
    
    func getReminderDate() -> Date? {
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
}
