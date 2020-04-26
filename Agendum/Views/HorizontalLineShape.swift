//
//  HorizontalLineShape.swift
//  Agendum
//
//  Created by Sian Pike on 14/02/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct HorizontalLineShape: Shape {
    
    func path(in rect: CGRect) -> Path {

        let fill = CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height)
        var path = Path()
            path.addRoundedRect(in: fill, cornerSize: CGSize(width: 2, height: 2))

        return path
    }

    struct HorizontalLine: View {
        private var color: Color? = nil
        private var height: CGFloat = 3.0
        private var width: CGFloat = 3.0

        init(color: Color, height: CGFloat = 3.0, width: CGFloat = 3.0) {
            self.color = color
            self.height = height
            self.width = width
        }

        var body: some View {
            HorizontalLineShape()
                .fill(self.color!)
                .frame(minWidth: 0, maxWidth: width, minHeight: 0, maxHeight: height)
        }
    }

    struct HorizontalLine_Previews: PreviewProvider {
        static var previews: some View {
            HorizontalLineShape
                .HorizontalLine(color: Color(red: 0.6, green: 1.0, blue: 0.8, opacity: 1.0), height: 3, width: 70)
        }
    }
}
