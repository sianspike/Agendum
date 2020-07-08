//
//  Dashboard.swift
//  Agendum
//
//  Created by Sian Pike on 14/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI
import SwiftUIPager

struct Dashboard: View {
    
    @EnvironmentObject var session: FirebaseSession
    @ObservedObject var viewRouter: ViewRouter
    @State var timePageNum = 0
    @State var calPageNum = 0
    var timePages: [String] = ["T o d a y", "T h i s  w e e k", "T h i s  M o n t h"]
    var calPages: [String] = ["A g e n d a", "C a l e n d a r"]
    
    var body: some View {
        
        ZStack {
            
            VStack(alignment: .leading) {
                
                Pager(page: self.$timePageNum, data: timePages, id: \.self) {
                    
                    TextWithBottomBorder(text: $0)
                    
                }.frame(height: 100)
                
                ProgressBar(progress: session.loggedInUser!.progress)
                
                Pager(page: self.$calPageNum, data: calPages, id: \.self) {
                    
                    TextWithBottomBorder(text: $0)
                        .font(Font.custom("Montserrat-Regular", size: 25))
                    
                }.frame(height: 100)
                
                if (calPageNum == 0) {
                            
                    AgendaView(timeFrame: timePageNum)
                            
                } else if (calPageNum == 1) {
                        
                    CalendarController(timeFrame: timePageNum)
                    //CalendarDisplayView(timeFrame: timePageNum)
                }
            }
            
            FloatingAddButton(action: {
                self.viewRouter.viewRouter = "Add Item"
            })
        }
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard(viewRouter: ViewRouter())
    }
}
