//
//  AllItemsHabitView.swift
//  Agendum
//
//  Created by Sian Pike on 02/11/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct AllItemsHabitView: View {
    
    @EnvironmentObject var session: FirebaseSession
    var searchText: String
    var filterClicked: Bool
    
    var body: some View {
        
        Text("H a b i t s")
            .font(Font.custom("Montserrat-SemiBold", size: 20))
            .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
            .multilineTextAlignment(.leading)
            .padding()
        
        if(!filterClicked) {
            
            ForEach(self.session.loggedInUser?.items.filter({searchText.isEmpty ? true : $0.getTitle().contains(searchText)}).sorted(by: {$0.title < $1.title}) ?? [], id: \.title) { item in
                
                let currentItem: Item = item
                
                if (currentItem.isHabit()) {
                    
                    ItemElement(item: currentItem)
                    
                }
            }
            
        } else {
            
            ForEach(self.session.loggedInUser?.items.filter({searchText.isEmpty ? true : $0.getTitle().contains(searchText)}).sorted(by: {$0.title > $1.title}) ?? [], id: \.title) { item in
                
                let currentItem: Item = item
                
                if (currentItem.isHabit()) {
                    
                    ItemElement(item: currentItem)
                    
                }
            }
        }

    }
}
