//
//  ViewRouter.swift
//  Agendum
//
//  Created by Sian Pike on 01/04/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import Foundation
import Combine

class ViewRouter: ObservableObject {
    
    let objectWillChange = PassthroughSubject<ViewRouter, Never>()
    
    @Published var viewRouter: String = "Dashboard" {
        didSet {
            objectWillChange.send(self)
        }
    }
}
