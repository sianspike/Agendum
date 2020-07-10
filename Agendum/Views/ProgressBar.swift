//
//  ProgressBar.swift
//  Agendum
//
//  Created by Sian Pike on 14/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct ProgressBar: View {
    
    var progress: Double
    
    var minPoints = 0
    var maxPoints = 100
    
    var body: some View {
        
        VStack {
            
            HStack {

                Text(String(minPoints))
                
                if #available(iOS 14.0, *) {
                    
                    ProgressView(value: progress/100).accentColor(Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0))
                    
                } else {
                    
                    ZStack(alignment: .leading) {

                        Rectangle().frame(width: 325, height: 20).foregroundColor(Color.white).border(Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0), width: 2)
                        Rectangle().frame(width: 325.0 * CGFloat(progress/100), height: 20).foregroundColor(Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0))
                    }
                }
                
                Text(String(maxPoints))
            }            
        }.padding()
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(progress: 50)
    }
}
