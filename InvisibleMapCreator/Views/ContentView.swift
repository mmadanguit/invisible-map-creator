//
//  ContentView.swift
//  InvisibleMapCreator
//
//  Created by Marion Madanguit on 2/22/21.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    @State private var isShowing = false
    
    var body: some View {
        NavigationView {
            ZStack {
                HomeView()
                    .offset(x: isShowing ? 100 : 0, y: 0)
                    // Menu button
                    .navigationBarItems(leading: Button(action: { withAnimation(.spring()) {
                            isShowing.toggle()
                        }
                    }, label: {
                        Text("Menu")
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }))
                
                if isShowing {
                    SideMenuView()
                }
            }
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

struct HomeView: View {
    var body: some View {
        ZStack {
            Text("Camera View")
            // return ARViewContainer().edgesIgnoringSafeArea(.all)
        }
    }
}
