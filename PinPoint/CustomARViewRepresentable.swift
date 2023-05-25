//
//  CustomARViewRepresentable.swift
//  PinPoint
//
//  Created by Vicky Goh on 18/05/23.
//

import SwiftUI

struct CustomARViewRepresentable: UIViewRepresentable{
    func makeUIView(context: Context) -> CustomARView {
        return CustomARView()
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) { }
}
