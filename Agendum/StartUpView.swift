//
//  StartUpView.swift
//  Agendum
//
//  Created by Sian Pike on 17/03/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct StartUpView: View {
    var body: some View {
        ZStack{
            Text("A G E N D U M")
                .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
                .font(Font.custom("Montserrat-Bold", size: 30))
        }.frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: .infinity, maxHeight: .infinity)
            .background(Color(.white))
    }
}

struct StartUpView_Previews: PreviewProvider {
    static var previews: some View {
        StartUpView()
    }
}
