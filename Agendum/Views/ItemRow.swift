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
    @State private var completed = false
    @State var dragOffset = CGSize.zero
    
    var body: some View {
        
        Group {
            
            if (isEvent && item.isDateSet()) {
                
                ZStack {
                    
                    HStack{
                                
                        Text(String(item.getTitle()))
                            .background(Color(.white))
                            .foregroundColor(completed ? Color(.gray) : Color(.black))
                            .frame(alignment: .leading)
                        
                        Spacer()
                                
                        Button(action: {
                                    
                            self.item.toggleCompleted()
                            self.completed.toggle()
                                    
                        }) {
                                    
                            Image(uiImage: UIImage(named: completed ? "Icons/Complete Tick.png" : "Icons/InComplete Tick.png")!)
                                .resizable()
                                .renderingMode(.original)
                                .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
                                .frame(width: 30, height: 30)
                                    
                        }.frame(alignment: .trailing)
                        .background(Color(.white))
                            
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.white))
                    .offset(x: self.dragOffset.width)
                        .gesture(completed ? DragGesture()
                            .onChanged { value in
                                self.dragOffset = value.translation
                            }
                            .onEnded { value in
                                self.dragOffset = .zero
                            } : nil)
                    
                }.frame(maxWidth: .infinity)
                .background(Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0))
                
            } else if (isReminder && item.isReminderSet()) {
                
                ZStack {
                    
                    HStack{
                                
                        Text(String(item.getTitle()))
                            .background(Color(.white))
                            .foregroundColor(completed ? Color(.gray) : Color(.black))
                            .frame(alignment: .leading)
                        
                        Spacer()
                                
                        Button(action: {
                                    
                            self.item.toggleCompleted()
                            self.completed.toggle()
                                    
                        }) {
                                    
                            Image(uiImage: UIImage(named: completed ? "Icons/Complete Tick.png" : "Icons/InComplete Tick.png")!)
                                .resizable()
                                .renderingMode(.original)
                                .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
                                .frame(width: 30, height: 30)
                                    
                        }.frame(alignment: .trailing)
                        .background(Color(.white))
                            
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.white))
                    .offset(x: self.dragOffset.width)
                        .gesture(completed ? DragGesture()
                            .onChanged { value in
                                self.dragOffset = value.translation
                            }
                            .onEnded { value in
                                self.dragOffset = .zero
                            } : nil)
                    
                }.frame(maxWidth: .infinity)
                .background(Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0))
                
            } else if (isTask && item.isTask()){
                
                ZStack {
                    
                    HStack{
                                
                        Text(String(item.getTitle()))
                            .background(Color(.white))
                            .foregroundColor(completed ? Color(.gray) : Color(.black))
                            .frame(alignment: .leading)
                        
                        Spacer()
                                
                        Button(action: {
                                    
                            self.item.toggleCompleted()
                            self.completed.toggle()
                                    
                        }) {
                                    
                            Image(uiImage: UIImage(named: completed ? "Icons/Complete Tick.png" : "Icons/InComplete Tick.png")!)
                                .resizable()
                                .renderingMode(.original)
                                .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
                                .frame(width: 30, height: 30)
                                    
                        }.frame(alignment: .trailing)
                        .background(Color(.white))
                            
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.white))
                    .offset(x: self.dragOffset.width)
                        .gesture(completed ? DragGesture()
                            .onChanged { value in
                                self.dragOffset = value.translation
                            }
                            .onEnded { value in
                                self.dragOffset = .zero
                            } : nil)
                    
                }.frame(maxWidth: .infinity)
                .background(Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0))
            }
        }
    }
}
