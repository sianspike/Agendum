//
//  AllItemsCompletedView.swift
//  Agendum
//
//  Created by Sian Pike on 02/11/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct AllItemsCompletedView: View {
    
    @EnvironmentObject var session: FirebaseSession
    var searchText: String
    
    var body: some View {
        
        Text("C o m p l e t e d")
            .font(Font.custom("Montserrat-SemiBold", size: 20))
            .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
            .multilineTextAlignment(.leading)
            .padding()
        
        ForEach(self.session.loggedInUser?.items.filter({searchText.isEmpty ? true : $0.getTitle().contains(searchText)}) ?? [], id: \.title) { item in
            
            let currentItem: Item = item
            
            if (currentItem.isCompleted()) {
                
                ItemElement(item: currentItem)
                
            }
        }
    }
}
