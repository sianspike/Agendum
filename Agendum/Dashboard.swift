//
//  Dashboard.swift
//  Agendum
//
//  Created by Sian Pike on 14/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct Dashboard: View {
    var body: some View {
        VStack {
            TextWithBottomBorder(text: "T o d a y")
        }.padding()
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}
