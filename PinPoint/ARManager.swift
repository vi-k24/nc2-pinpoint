//
//  ARManager.swift
//  PinPoint
//
//  Created by Vicky Goh on 19/05/23.
//

import Combine

class ARManager{
    static let shared = ARManager()
    private init() { }
    
    var actionStream = PassthroughSubject<ARAction, Never>()
}
