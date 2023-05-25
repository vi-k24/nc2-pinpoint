//
//  CustomARView.swift
//  PinPoint
//
//  Created by Vicky Goh on 18/05/23.
//

import ARKit
import Combine
import RealityKit
import SwiftUI

class CustomARView: ARView {
    static var pinArray: [Pin.Scene] = []
//    let encodedData = try NSKeyedArchiver.archivedData(withRootObject: CustomARView.pinArray, requiringSecureCoding: true)
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    @available(*, unavailable)
    dynamic required init?(coder Decoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    // The init that we are going to use
    convenience init(){
        self.init(frame: UIScreen.main.bounds)
        subscribeToActionStream()
    }
    
    private var cancellables: Set<AnyCancellable> = []
    func subscribeToActionStream() {
        ARManager.shared
            .actionStream
            .sink { [weak self] action in
                switch action {
                case .placePin:
                    do {
                        let pin = try Pin.loadScene()
                        CustomARView.pinArray.append(pin)
                        print(CustomARView.pinArray.count)
                        self?.scene.addAnchor(pin)

                        let userDefaults = UserDefaults.standard

                        guard let savedData = userDefaults.data(forKey: "pinArray"),
                              let savedPinArray = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? [Pin.Scene]
                        else {
//                            CustomARView.pinArray = []
                            return
                        }

//                        CustomARView.pinArray = savedPinArray
                        print(CustomARView.pinArray.count)

//                        let encodedData = try NSKeyedArchiver.archivedData(withRootObject: CustomARView.pinArray, requiringSecureCoding: true)
//                        userDefaults.set(encodedData, forKey: "pinArray")
                    } catch {
                        print("Failed to load pin scene:", error)
                    }

                case .removeAnchors:
                    // Check if there are pins to remove
                   guard CustomARView.pinArray.count > 0 else {
                       return
                   }
                    // Remove the last pin from pinArray and scene
                    var indexPin = CustomARView.pinArray.count
                    print(indexPin)
                    let removedPin = CustomARView.pinArray.remove(at: indexPin - 1)
                    self?.scene.removeAnchor(removedPin)


                    // Update UserDefaults with the modified pinArray
//                    self?.updateUserDefaults()
//                    return
                  
                }
                
            }
            .store(in: &cancellables)
    }
//    private func updateUserDefaults() {
//        let userDefaults = UserDefaults.standard
//        let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: CustomARView.pinArray, requiringSecureCoding: true)
//        userDefaults.set(encodedData, forKey: "pinArray")
//    }
}


//    func saveData() -> Data? {
//        let userDefaults = UserDefaults.standard
//
//        if let pinArray = userDefaults.object(forKey: "pinArray") as? [Pin] {
//            // User default value is not nil and can be cast to [Pin]
//            guard let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: pinArray, requiringSecureCoding: true) else {
//                return nil
//            }
//            // Use the encodedData variable here
//        } else {
//            // User default value is nil or cannot be cast to [Pin]
//            // Handle the case where the value is nil or incompatible
//        }
//    }

//    func subscribeToActionStream() {
//        ARManager.shared
//            .actionStream
//            .sink { [weak self] action in
//                switch action {
//                case .placePin:
//                    do {
//                        let pin = try Pin.loadScene()
//                        CustomARView.pinArray.append(pin)
//                        self?.scene.addAnchor(pin)
//
//                        let userDefaults = UserDefaults.standard
//                        userDefaults.set(CustomARView.pinArray, forKey: "pinArray")
//                    } catch {
//                        print("Failed to load pin scene:", error)
//                    }
//
//                    case .removeAnchors:
//                    // TODO :
//                    // 1. Get index dari pin yang di tap / selected, index pasti berupa INTEGER
//                    // 2. Passing index tersebut untuk di remove dari screen ke function dibawah, ganti 0 menjadi index
//                    self?.scene.anchors.removeAll()
//                }
//            }
//            .store(in: &cancellables)
//    }


/*
    func configurationExamples(){
        //Tracks the device relative to its environment
        let configuration = ARWorldTrackingConfiguration()
        session.run(configuration)

        //Not support in all regions, track w.r.t. global coordinates
        let _ = ARGeoTrackingConfiguration()

        //Tracks face in the scene
        let _ = ARFaceTrackingConfiguration()

        //Tracks bodies in the scene
        let _ = ARBodyTrackingConfiguration()
    }

    func anchorExamples(){
        //Attach anchors at specific coordinates in the iPhone centered coordinate system
        let coordinateAnchor = AnchorEntity(world: .zero)

        //Attach anchor to detected planes (this works best on devices with a LIDAR sensor
        let _ = AnchorEntity(plane:.horizontal)
        let _ = AnchorEntity(plane: .vertical)

        //Attach anchors to tracked body parts, such as face
        let _ = AnchorEntity(.face)

        //Attach anchors to tracked images, such as markers or visual codes
        let _ = AnchorEntity(.image(group: "group", name: "name")

        //Add an anchor to the scene
        scene.addAnchor(coordinateAnchor)

    func entityExamples{
        //load an entity from usdz file
        let _ = try? Entity.load(named: "usdzfilename")

        //load an entity from a reality file
        let _ = try? Entity.load(named: "realityFileName")

        //generate an entity with code
        let box = MeshResource.generateBox(size:1)
        let entity = ModelEntity(mesh:box)

        //add an entity to an anchor, so it's placed in the scene
        let anchor = AnchorEntity()
        anchor.addChild(entity)
    }


//    func placeBlueBlock(ofColor color : Color) {
//        let block = MeshResource.generateBox(size:0)
//        let material = SimpleMaterial(color: UIColor(color), isMetallic: false)
//        let entity = ModelEntity(mesh:block, materials: [material])
//
//        let anchor = AnchorEntity(plane: .horizontal)
//        anchor.addChild(entity)
//
//        scene.addAnchor(anchor)
//    }
 */



//import ARKit
//import Combine
//import RealityKit
//import SwiftUI
//
//struct CodablePinScene: Codable {
//    let sceneData: Data
//}
//
//class CustomARView: ARView {
//    required init(frame frameRect: CGRect) {
//        super.init(frame: frameRect)
//    }
//
//    dynamic required init?(coder Decoder: NSCoder){
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // The init that we are going to use
//    convenience init(){
//        self.init(frame: UIScreen.main.bounds)
//        subscribeToActionStream()
//    }
//
//    private var cancellables: Set<AnyCancellable> = []
//    func subscribeToActionStream(){
//        ARManager.shared
//            .actionStream
//            .sink{ [weak self] action in
//                switch action {
//                case .placePin:
//                    do {
//                        let pin = try Pin.loadScene()
//                        self?.scene.addAnchor(pin)
//                        CustomARView.pinArray.append(pin)
//
//                        let userDefaults = UserDefaults.standard
//                        do {
//                            let encoder = JSONEncoder()
//                            let encodedData = try encoder.encode(CustomARView.pinArray.map { CodablePinScene(sceneData: try NSKeyedArchiver.archivedData(withRootObject: $0)) })
//                            userDefaults.set(encodedData, forKey: "pinArray")
//                        } catch {
//                            print("Failed to encode pinArray:", error)
//                        }
//                    } catch {
//                        print(error)
//                    }
//                case .removeAnchors:
//                    self?.removeAnchors()
//                }
//            }
//            .store(in: &cancellables)
//    }
//
//    func removeAnchors() {
//        CustomARView.pinArray.forEach { anchorToRemove in
//            if let index = scene.anchors.firstIndex(where: { $0 === anchorToRemove }) {
//                scene.anchors.remove(at: index)
//            }
//        }
//        CustomARView.pinArray.removeAll()
//
//        let userDefaults = UserDefaults.standard
//        do {
//            let encoder = JSONEncoder()
//            let encodedData = try encoder.encode(CustomARView.pinArray.map { CodablePinScene(sceneData: try NSKeyedArchiver.archivedData(withRootObject: $0)) })
//            userDefaults.set(encodedData, forKey: "pinArray")
//        } catch {
//            print("Failed to encode pinArray:", error)
//        }
//    }
//}
//
//extension CustomARView {
//    static var pinArray: [Pin.Scene] {
//        get {
//            let userDefaults = UserDefaults.standard
//            if let pinData = userDefaults.data(forKey: "pinArray") {
//                do {
//                    let decoder = JSONDecoder()
//                    let codablePinScenes = try decoder.decode([CodablePinScene].self, from: pinData)
//                    return codablePinScenes.compactMap { pinScene in
//                        guard let sceneData = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(pinScene.sceneData) as? Pin.Scene else {
//                            return nil
//                        }
//                        return sceneData
//                    }
//                } catch {
//                    print("Failed to decode pinArray:", error)
//                }
//            }
//            return []
//        }
//        set {
//            let userDefaults = UserDefaults.standard
//            do {
//                let encoder = JSONEncoder()
//                let encodedData = try encoder.encode(newValue.map { CodablePinScene(sceneData: try NSKeyedArchiver.archivedData(withRootObject: $0)) })
//                userDefaults.set(encodedData, forKey: "pinArray")
//            } catch {
//                print("Failed to encode pinArray:", error)
//            }
//        }
//    }
//}
