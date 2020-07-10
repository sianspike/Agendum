//
//  CalendarController.swift
//  Agendum
//
//  Created by Sian Pike on 08/07/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct CalendarController: View {
    
    var timeFrame: Int
    
    var body: some View {
        
        Group {
            
            if (timeFrame == 0) {
                
                CalendarTodayView()
                
            } else if (timeFrame == 1) {
                
                CalendarWeekView()
                
            } else if (timeFrame == 2) {
                
                CalendarMonthView()
            }
        }
    }
}

struct CalendarController_Previews: PreviewProvider {
    static var previews: some View {
        CalendarController(timeFrame: 0)
    }
}
