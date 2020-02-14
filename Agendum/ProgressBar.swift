//
//  ProgressBar.swift
//  Agendum
//
//  Created by Sian Pike on 14/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct ProgressBar: View {
    var body: some View {
        ZStack {
            Rectangle().frame(height: 20).foregroundColor(Color.white).border(Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0), width: 2)
            Rectangle().frame(height: 20).foregroundColor(Color(red: 0.6, green: 0.8, blue: 1.0, opacity: 1.0))
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar()
    }
}
