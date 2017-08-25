//
//  DynamicBind.swift
//  MVVM-Example
//
//  Created by Pierre jonny cau on 17/08/2017.
//  Copyright © 2017 Pierre Jonny Cau. All rights reserved.
//

import Foundation

class DynamicBind<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    func bind(listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
}
