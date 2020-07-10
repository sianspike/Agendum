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
            
        HStack {
            Button(action: {
                self.viewRouter.viewRouter = "Focus"
            }) {
                VStack {
                    HorizontalLineShape
                        .HorizontalLine(color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), height: 3, width: 70)
                    
                    Image(uiImage: UIImage(named: "Icons/Timer.png")!)
                        .renderingMode(.original)
                }
            }.padding([.horizontal])

            Button(action: {
                    self.viewRouter.viewRouter = "All Items"
            }) {
                VStack {
                    HorizontalLineShape
                        .HorizontalLine(color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), height: 3, width: 70)
                    Image(uiImage: UIImage(named: "Icons/List.png")!)
                        .renderingMode(.original)
                }
            }.padding([.horizontal])

            Button(action: {
                self.viewRouter.viewRouter = "Dashboard"
            }) {
                VStack {
                    HorizontalLineShape
                        .HorizontalLine(color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), height: 3, width: 70)
                    Image(uiImage: UIImage(named: "Icons/Home.png")!)
                        .renderingMode(.original)
                }
            }.padding([.horizontal])

            Button(action:{
                self.viewRouter.viewRouter = "Friends"
            }) {
                VStack {
                    HorizontalLineShape
                        .HorizontalLine(color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), height: 3, width: 70)
                    Image(uiImage: UIImage(named: "Icons/People.png")!)
                        .renderingMode(.original)
                }
            }.padding([.horizontal])

            Button(action: {
                self.viewRouter.viewRouter = "Settings"
            }) {
                VStack {
                    HorizontalLineShape
                        .HorizontalLine(color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), height: 3, width: 70)
                    Image(uiImage: UIImage(named: "Icons/Settings.png")!)
                        .renderingMode(.original)
                }
            }.padding([.horizontal])
        }.frame(maxWidth: .infinity)
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(viewRouter: ViewRouter())
    }
}
