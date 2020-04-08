//
//  FocusView.swift
//  Agendum
//
//  Created by Sian Pike on 24/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct FocusView: View {
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        
        VStack {
            
            TextWithBottomBorder(text: "F o c u s")
            
            Spacer()
            
            Timer().padding(.bottom)
            
            ButtonOne(text: "B E G I N", color: Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0), action: {})
            
            Spacer()
            
            Text("C u r r e n t  T a s k")
                .font(Font.custom("Monsterrat-Regular", size: 20))
            
            Spacer()
        }
    }
}

struct FocusView_Previews: PreviewProvider {
    static var previews: some View {
        FocusView(viewRouter: ViewRouter())
    }
}
