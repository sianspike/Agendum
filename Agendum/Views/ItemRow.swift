//
//  ItemRow.swift
//  Agendum
//
//  Created by Sian Pike on 10/05/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct ItemRow: View {
    
    var item: Item
    var isEvent: Bool
    var isReminder: Bool
    var isTask: Bool
    var timeFrame: Int
    let today = Calendar.current.component(.day, from: Date())
    let thisWeek = Calendar.current.component(.weekOfYear, from: Date())
    let thisMonth = Calendar.current.component(.month, from: Date())
    let thisYear = Calendar.current.component(.year, from: Date())
    
    func chooseCategory() -> AnyView {
        
        if (isEvent && item.isEvent()) {
                
            return AnyView(ItemElement(item: item))
                
        } else if (isReminder && item.isReminderSet()) {
                
            return AnyView(ItemElement(item: item))
                
        } else if (isTask && item.isTask()){
                
            return AnyView(ItemElement(item: item))
        }
        
        return AnyView(EmptyView())
    }
    
    var body: some View {

        Group {
            
            if (timeFrame == 0 && item.isDateSet()) {
                    
                if (Calendar.current.component(.day, from: item.getDate()! as Date) == today && Calendar.current.component(.month, from: item.getDate()! as Date) == thisMonth && Calendar.current.component(.year, from: item.getDate()! as Date) == thisYear) {
                        
                    chooseCategory()
                }
            } else if (timeFrame == 1 && item.isDateSet()) {
                
                if (Calendar.current.component(.weekOfYear, from: self.item.getDate()! as Date) == thisWeek && Calendar.current.component(.month, from: item.getDate()! as Date) == thisMonth && Calendar.current.component(.year, from: item.getDate()! as Date) == thisYear) {
                    
                    chooseCategory()
                }
            } else if (timeFrame == 2 && item.isDateSet()) {
                
                if (Calendar.current.component(.month, from: item.getDate()! as Date) == thisMonth && Calendar.current.component(.year, from: item.getDate()! as Date) == thisYear) {
                    
                    chooseCategory()
                }
            }
        }
    }
}
