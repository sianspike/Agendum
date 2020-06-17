//
//  ItemElement.swift
//  Agendum
//
//  Created by Sian Pike on 02/06/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct ItemElement: View {
    
    var item: Item
    @State var dragOffset = CGSize.zero
    @EnvironmentObject var session: FirebaseSession
    
    var body: some View {
        
        ZStack {
                    
            HStack{
                            
                Text(String(item.getTitle()))
                    .strikethrough(self.item.isCompleted() ? true : false, color: Color(.gray))
                    .background(Color(.white))
                    .foregroundColor(self.item.isCompleted() ? Color(.gray) : Color(.black))
                    .frame(alignment: .leading)
                            
                Spacer()
                                    
                Button(action: {
                                        
                    self.item.toggleCompleted()
                                
                    if (self.item.isCompleted()) {
                                    
                        self.session.loggedInUser!.progress += 1
                                    
                    } else {
                                    
                        self.session.loggedInUser!.progress -= 1
                    }
                                
                    self.session.saveProgress(progress: self.session.loggedInUser!.progress)
                    self.session.saveItem(item: self.item)
                                        
                }) {
                                        
                    Image(uiImage: UIImage(named: self.item.isCompleted() ? "Icons/Complete Tick.png" : "Icons/InComplete Tick.png")!)
                        .resizable()
                        .renderingMode(.original)
                        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
                        .frame(width: 30, height: 30)
                                        
                }
                    .frame(alignment: .trailing)
                    .background(Color(.white))
                            
            }
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.white))
                .offset(x: self.dragOffset.width)
                    .gesture(DragGesture()
                        .onChanged { value in
                                    
                            self.dragOffset = value.translation
                        }
                        .onEnded { value in
                            
                            if (self.dragOffset.width < 0) {
                                
                                self.session.deleteItem(item: self.item)
                                self.session.retrieveItems()
                                
                            } else if (self.dragOffset.width > 0) {
                                
                                //edit item
                            }
                            
                            self.dragOffset = .zero
                        })
                    
        }
            .frame(maxWidth: .infinity)
            .background(Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0))
    }
}
