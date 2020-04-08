//
//  HomeView.swift
//  Agendum
//
//  Created by Sian Pike on 06/04/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            
            NavigationBar(viewRouter: viewRouter)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewRouter: ViewRouter())
    }
}
