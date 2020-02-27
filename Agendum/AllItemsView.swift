//
//  AllItemsView.swift
//  Agendum
//
//  Created by Sian Pike on 27/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct AllItemsView: View {
    var body: some View {
        
        VStack (alignment: .leading){
            
            TextWithBottomBorder(text: "All Items")
            
            HStack {
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Image(uiImage: UIImage(named: "Icons/Filter.png")!)
                        .renderingMode(.original)
                        .padding(.horizontal)
                }
                
                TextField("Search", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/).textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Image(uiImage: UIImage(named: "Icons/Search.png")!)
                        .renderingMode(.original)
                        .padding(.horizontal)
                }
            }
            
            Text("D u e  S o o n")
                .font(Font.custom("Montserrat-SemiBold", size: 20))
                .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
                .multilineTextAlignment(.leading)
                .padding()
            
            Text("H a b i t s")
                .font(Font.custom("Montserrat-SemiBold", size: 20))
                .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
                .multilineTextAlignment(.leading)
                .padding()
            
            Text("C u s t o m  L a b e l  1")
                .font(Font.custom("Montserrat-SemiBold", size: 20))
                .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
                .multilineTextAlignment(.leading)
                .padding()
            
            Spacer()
            
            NavigationBar()
        }
    }
}

struct AllItemsView_Previews: PreviewProvider {
    static var previews: some View {
        AllItemsView()
    }
}
