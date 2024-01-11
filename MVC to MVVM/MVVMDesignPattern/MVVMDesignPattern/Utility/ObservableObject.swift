//
//  ObservableObject.swift
//  MVVMDesignPattern
//
//  Created by Jason Pinlac on 4/27/23.
//

import Foundation

final class ObservableObject<T> {
    
    var value: T {
        didSet {
            listeners.forEach { listener in
                listener(value)
            }
        }
    }
    
    private var listeners: [((T) -> Void)] = []
    
    init(value: T) {
        self.value = value
    }
    
    func bind(listener: @escaping (T) -> Void) {
        self.listeners.append(listener)
        listener(value)
    }
    
}
