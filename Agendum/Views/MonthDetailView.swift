//
//  MonthDetailView.swift
//  Agendum
//
//  Created by Sian Pike on 24/08/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct MonthDetailView: View {
    
    let items: [Item]
    
    var body: some View {
        
        ScrollView {
                
            ForEach(items, id: \.title) { item in
                        
                Text(item.getTitle())
                    .font(Font.custom("Montserrat-SemiBold", size: 20))
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
            }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding(.vertical)
    }
}
