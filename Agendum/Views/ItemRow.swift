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
    
    var body: some View {
        
        Group {
            
            if (isEvent && item.isDateSet()) {
                
                Text(String(item.getDate()!.description))
                
            } else if (isReminder && item.isReminderSet()) {
                
                Text(String(item.getReminderDate()!.description))
                
            } else if (isTask && item.isTask()){
                
                Text(item.getTitle())
                
            } else {
                
                Text("none")
            }
        }
    }
}
