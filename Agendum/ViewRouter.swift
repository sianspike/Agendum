//
//  ViewRouter.swift
//  Agendum
//
//  Created by Sian Pike on 18/03/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class ViewRouter : ObservableObject {
    
    let objectWillChange = PassthroughSubject<ViewRouter, Never>()
    
    var currentPage : String = "Sign Up" {
        didSet {
            objectWillChange.send(self)
        }
    }

}
