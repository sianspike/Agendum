//
//  Buildable.swift
//  iPod
//
//  Created by Fernando Moya de Rivas on 09/12/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation

/// Adds a helper function to mutate a properties and help implement _Builder_ pattern
protocol Buildable { }

extension Buildable {

    /// Mutates a property of the instance
    ///
    /// - Parameter keyPath:    `WritableKeyPath` to the instance property to be modified
    /// - Parameter value:      value to overwrite the  instance property
    func mutating<T>(keyPath: WritableKeyPath<Self, T>, value: T) -> Self {
        var newSelf = self
        newSelf[keyPath: keyPath] = value
        return newSelf
    }

}
