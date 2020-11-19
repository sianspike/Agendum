//
//  FocusView.swift
//  Agendum
//
//  Created by Sian Pike on 24/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI
import Combine
import SwiftUIPager

struct FocusView: View {
    
    @ObservedObject var viewRouter: ViewRouter
    @State var currentPage: Int = 0
    @State var selectedTask: String = "No task selected"
    @State var focusTimerLength = 0
    @State var breakTimerLength = 0
    @State var focusTimerInterval: TimeInterval? = 1500 //25 mins
    @State var breakTimerInterval: TimeInterval? = 300 //5 mins
    var pageItems: [Int] = [0, 1]
    
    func pageView(_ page: Int) -> AnyView {
        
        if (page == 0) {
            
            return AnyView(FocusPageOneView(focusTimerInterval: $focusTimerInterval, breakTimerInterval: $breakTimerInterval, selectedTask: $selectedTask, focusTimerLength: $focusTimerLength, breakTimerLength: $breakTimerLength))
            
        } else {
            
            return AnyView(FocusPageTwoView(focusTimerInterval: $focusTimerInterval, breakTimerInterval: $breakTimerInterval, selectedTask: $selectedTask))
        }
    }
    
    var body: some View {
            
        VStack {
                
            TextWithBottomBorder(text: "F o c u s")
                
            Pager(page: $currentPage, data: pageItems, id: \.self, content: { index in

                self.pageView(index)
            })
        }
    }
}

struct FocusView_Previews: PreviewProvider {
    static var previews: some View {
        FocusView(viewRouter: ViewRouter())
    }
}
