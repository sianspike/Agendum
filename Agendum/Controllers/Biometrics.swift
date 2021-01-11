//
//  Biometrics.swift
//  Agendum
//
//  Created by Sian Pike on 05/01/2021.
//  Copyright © 2021 Sian Pike. All rights reserved.
//

import Foundation
import Combine
import LocalAuthentication

class Biometrics {
    
    func tryBiometricAuthentication() -> Bool {
        
        let context: LAContext = LAContext()
        var error: NSError?
        var success = false
        let group = DispatchGroup()
        group.enter()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            let reason = "Authenticate to unlock your account."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { authenticated, error in
                
                DispatchQueue.global(qos: .default).async {
                    
                    if authenticated {
                        
                        success = true
                        
                    } else {
                        
                        if let errorString = error?.localizedDescription {
                            
                            print("Error in biometric policy evaluation: \(errorString)")
                        }
                        
                        success = false
                    }
                    
                    group.leave()
                }
            }
        } else {
            
            if let errorString = error?.localizedDescription {
                
                print("Error in biometric policy evaluation: \(errorString)")
            }
            
            success = false
        }
        
        group.wait()
        return success
    }
    
    func faceIDAvailable() -> Bool {
        
        if #available(iOS 11.0, *) {
            
            let context: LAContext = LAContext()
            return (context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthentication, error: nil) && context.biometryType == .faceID)
        }
        return false
    }
}
