//
//  ContentView.swift
//  VisionPro-Volume-None-Playground
//
//  Created by Daniel Reyes on 22/06/23.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    @State var enlarge = false

    var body: some View {
        VStack {
            RealityView { content in
                // Add the initial RealityKit content
                if let scene = try? await Entity(named: "Scene", in: realityKitContentBundle) {
                    content.add(scene)
                    
                        // TODO: Check first the original scene
//                    if let firstScene = content.entities.first {
//                        let uniformScale: Float = 0.0001
//                        firstScene.transform.scale = [
//                            uniformScale,
//                            uniformScale,
//                            uniformScale
//                        ]
//                    }
                }
            } update: { content in
                // Update the RealityKit content when SwiftUI state changes
                if let scene = content.entities.first {
                    let uniformScale: Float = enlarge ? 1.4 : 1.0
                    scene.transform.scale = [uniformScale, uniformScale, uniformScale]
                }
            }
            .gesture(TapGesture().targetedToAnyEntity().onEnded { _ in
                enlarge.toggle()
            })

            VStack {
                Toggle("Enlarge RealityView Content", isOn: $enlarge)
                    .toggleStyle(.button)
            }.padding().glassBackgroundEffect()
        }
    }
    
    private func loadModel() -> Entity {
        let path = Bundle.main.path(forResource: "HumanHeart", ofType: "usdz")!
        let url = URL(fileURLWithPath: path)
        let entity = try! Entity.load(contentsOf: url)
        
        
        
            // Entity
//            let entity = scene.children[0] as! ModelEntity
//            entity.model?.materials[0] = UnlitMaterial(color: .red)
            
//            let anchor = AnchorEntity(plane: .any)
//            anchor.addChild(scene)
            
            
            // arView.scene.anchors.append(anchor)
        return entity
    }
}

#Preview {
    ContentView()
}
