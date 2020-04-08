//
//  NavigationBar.swift
//  Agendum
//
//  Created by Sian Pike on 21/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct NavigationBar: View {
    
    @ObservedObject var viewRouter: ViewRouter
    
    let gradientColours = Gradient(colors:[Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), .white])
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack{
                HorizontalLineShape
                    .HorizontalLine(color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), height: 3, width: 163)
                
                Spacer()
                
                HorizontalLineShape
                    .HorizontalLine(color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), height: 3, width: 163)
                
            }.frame(maxWidth: .infinity, alignment: .leading)
            
            HStack{
                Button(action: {
                    self.viewRouter.viewRouter = "Focus"
                }) {
                    Image(uiImage: UIImage(named: "Icons/Timer.png")!)
                        .renderingMode(.original)
                }.padding([.horizontal])
                
                Button(action: {
                    self.viewRouter.viewRouter = "All Items"
                }) {
                    Image(uiImage: UIImage(named: "Icons/List.png")!)
                    .renderingMode(.original)
                }.padding([.horizontal])
                
                HorizontalLineShape
                    .HorizontalLine(color: .clear, height: 50, width: 3)
                    .foregroundColor(.clear)
                    .background(LinearGradient(gradient: gradientColours, startPoint: .top, endPoint: .bottom))
                
                Button(action: {
                    self.viewRouter.viewRouter = "Dashboard"
                }) {
                    Image(uiImage: UIImage(named: "Icons/Home.png")!)
                    .renderingMode(.original)
                }.padding([.horizontal])
                
                HorizontalLineShape
                    .HorizontalLine(color: .clear, height: 50, width: 3)
                .foregroundColor(.clear)
                .background(LinearGradient(gradient: gradientColours, startPoint: .top, endPoint: .bottom))
                
                Button(action:{
                    self.viewRouter.viewRouter = "Friends"
                }) {
                    Image(uiImage: UIImage(named: "Icons/People.png")!)
                    .renderingMode(.original)
                }.padding([.horizontal])
                
                Button(action: {
                    self.viewRouter.viewRouter = "Settings"
                }) {
                    Image(uiImage: UIImage(named: "Icons/Settings.png")!)
                    .renderingMode(.original)
                }.padding([.horizontal])
            }.frame(maxWidth: .infinity)
        }
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(viewRouter: ViewRouter())
    }
}
