//
//  ContentView.swift
//  PinPoint
//
//  Created by Vicky Goh on 17/05/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        CustomARViewRepresentable()
            .ignoresSafeArea()
            .overlay(alignment : .bottom){
                VStack(alignment: .leading){
                    HStack (alignment: .firstTextBaseline) {
                            Text("Set Your Pin Point")
                            Image(systemName: "mappin.and.ellipse")
                            .padding(.leading, 50)
                        }
                        .font(.system(size: 32))
                        .shadow(radius: 2,x: 0, y: 2)
                        .foregroundColor(.white)
                        
                        Spacer()
                        
                    HStack(alignment: .center){
                            Button{
                                ARManager.shared.actionStream.send(.removeAnchors)
                            }label: {
                                Image(systemName: "trash.circle.fill")
                            }
                            
                            Button{
                                ARManager.shared.actionStream.send(.placePin)
                            }label: {
                                Image(systemName: "plus.circle")
                            }
                        }
                        .font(.system(size: 72))
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .padding(.bottom, 20)
                        .padding(.leading, 80)
                        
                    }
                        .padding()
                    }
                }
            }
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
