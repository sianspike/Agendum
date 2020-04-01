//
//  GoToDashboard.swift
//  Agendum
//
//  Created by Sian Pike on 30/03/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class GoToDashboard : ObservableObject {
    
    let objectWillChange = PassthroughSubject<GoToDashboard, Never>()
    
    @Published var goToDashboard: Bool = false {
        didSet {
            objectWillChange.send(self)
        }
    }

}
