//
//  VerticalLineShape.swift
//  Agendum
//
//  Created by Sian Pike on 21/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct VerticalLineShape: Shape {
    func path(in rect: CGRect) -> Path {

        let fill = CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height)
        var path = Path()
            path.addRoundedRect(in: fill, cornerSize: CGSize(width: 2, height: 2))

        return path
    }
}

struct VerticalLine: View {
    private var color: Color? = nil
    private var height: CGFloat = 1.0

    init(color: Color, height: CGFloat = 1.0) {
        self.color = color
        self.height = height
    }

    var body: some View {
    HorizontalLineShape().fill(self.color!).frame(minWidth: 0, maxWidth: .infinity, minHeight: height, maxHeight: height)
    }
}

struct VerticalLineShape_Previews: PreviewProvider {
    static var previews: some View {
        VerticalLine(color: .black)
    }
}
