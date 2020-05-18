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
                
                HStack{
                    Text(String(item.getTitle()))
                    
                    Button(action: {}) {
                        
                        Image(uiImage: UIImage(named: "Icons/InComplete Tick.png")!)
                            .resizable()
                            .renderingMode(.original)
                            .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
                            .frame(width: 30, height: 30)
                    }.frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                Divider()
                
            } else if (isReminder && item.isReminderSet()) {
                
                HStack{
                    Text(String(item.getTitle()))
                    
                    Button(action: {}) {
                        
                        Image(uiImage: UIImage(named: "Icons/InComplete Tick.png")!)
                            .resizable()
                            .renderingMode(.original)
                            .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
                            .frame(width: 30, height: 30)
                    }.frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                Divider()
                
            } else if (isTask && item.isTask()){
                
                HStack{
                    Text(String(item.getTitle()))
                    
                    Button(action: {}) {
                        
                        Image(uiImage: UIImage(named: "Icons/InComplete Tick.png")!)
                            .resizable()
                            .renderingMode(.original)
                            .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
                            .frame(width: 30, height: 30)
                    }.frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                Divider()
            }
        }
    }
}
