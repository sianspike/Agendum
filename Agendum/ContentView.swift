//
//  ContentView.swift
//  Agendum
//
//  Created by Sian Pike on 05/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("A G E N D U M")
            .foregroundColor(Color(red: 0.6, green: 0.9, blue: 1.0, opacity: 1.0))
            .font(Font.custom("Montserrat-Bold", size: 30))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
