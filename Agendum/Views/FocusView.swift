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
    @State private var timerLength = 0
    @State var timerTapped: Bool = false
    @State var beginTapped: Bool = false
    @State var timerInterval: TimeInterval? = 0
    @State var currentPage: Int = 0
    var pageItems: [Int] = [0, 1]
    var timeIntervals = ["25 minutes", "30 minutes", "50 minutes", "1 hour", "1.5 hours", "2 hours"]
    
    func convertToInterval(interval: Int) -> TimeInterval? {
        
        let minute: TimeInterval = 60.0
        let hour: TimeInterval = 60.0 * minute
        
        switch interval {
        
            case 0:
                timerInterval = minute * 25
            case 1:
                timerInterval = minute * 30
            case 2:
                timerInterval = minute * 50
            case 3:
                timerInterval = hour
            case 4:
                timerInterval = hour + (minute * 30)
            case 5:
                timerInterval = hour * 2
            default:
                timerInterval = nil
        }
        
        return timerInterval
    }
    
    func pageView(_ page: Int) -> AnyView {
        
        if (page == 0) {
            
            return AnyView(FocusPageOneView())
            
        } else {
            
            return AnyView(FocusPageTwoView())
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
