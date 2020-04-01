//
//  GoToSignIn.swift
//  Agendum
//
//  Created by Sian Pike on 18/03/2020.
//  Copyright © 2020 Sian Pike. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class GoToSignIn : ObservableObject {
    
    let objectWillChange = PassthroughSubject<GoToSignIn, Never>()
    
    @Published var goToSignIn: Bool = false {
        didSet {
            objectWillChange.send(self)
        }
    }

}
