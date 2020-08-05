//
//  ItemElement.swift
//  Agendum
//
//  Created by Sian Pike on 02/06/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI
import CareKitUI

struct ItemElement: View {
    
    var item: Item
    @State var dragOffset = CGSize.zero
    @EnvironmentObject var session: FirebaseSession
    
    func updateProgress(){
        
        self.item.toggleCompleted()
        
        if (self.item.isCompleted()) {
        
            self.session.loggedInUser!.progress += 1
        
        } else {
        
            self.session.loggedInUser!.progress -= 1
        }
        
        self.session.saveProgress(progress: self.session.loggedInUser!.progress)
        self.session.saveItem(item: self.item)
    }
    
    var body: some View {
        
        ZStack {
                
            SimpleTaskView(title: Text(item.getTitle())
                                    .strikethrough(self.item.isCompleted() ? true : false, color: Color(.gray))
                                    .foregroundColor(self.item.isCompleted() ? Color(.gray) : Color(.black)),
                           detail: nil, isComplete: item.isCompleted(), action: updateProgress)
                .accentColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
                .offset(x: self.dragOffset.width)
                .highPriorityGesture(DragGesture()
                            .onChanged { value in
        
                                self.dragOffset = value.translation
                            }
                            .onEnded { value in
        
                                if (self.dragOffset.width < 0) {
        
                                    self.session.deleteItem(item: self.item)
                                    self.session.retrieveItems()
        
                                } else if (self.dragOffset.width > 0) {
        
                                    //edit item
                                    print("Editting item")
                                }
        
                                self.dragOffset = .zero
                            })
                
        }
        .background(Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0))
        .cornerRadius(13)
    }
}
