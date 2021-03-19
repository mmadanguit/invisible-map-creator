//
//  ContentView.swift
//  InvisibleMapCreator
//
//  Created by Marion Madanguit on 3/5/21.
//

import SwiftUI

// All the view types that will exist as a popover
enum PopoverViewType {
    case optionsMenu
    case recordMap
}

// Announce any changes that occur to the popoverUI
class PopoverViewTypeWrapper: ObservableObject {
    @Published var popoverUI: PopoverViewType
    
    public init() {
        popoverUI = .recordMap
    }
}

// Store popoverViewWrapper outside of view struct
class GlobalState {
    public static var shared = GlobalState()
    var popoverViewWrapper = PopoverViewTypeWrapper()
    
    private init() {
        
    }
}

// MARK: - NavigationIndicator
struct NavigationIndicator: UIViewControllerRepresentable {
   typealias UIViewControllerType = ARView
   func makeUIViewController(context: Context) -> ARView {
      return ARView()
   }
   func updateUIViewController(_ uiViewController:
   NavigationIndicator.UIViewControllerType, context:
   UIViewControllerRepresentableContext<NavigationIndicator>) { }
}

struct ContentView: View {
    
    @ObservedObject var popoverViewWrapper = GlobalState.shared.popoverViewWrapper // Track changes to popoverUI
    
    init() {
        AppController.shared.contentViewer = self
    }
    
    var body: some View {

        ZStack {
          NavigationIndicator().edgesIgnoringSafeArea(.all)
          CameraButtons()
/*
          Button(action: {
            showPopover = true
            AppController.shared.optionsMenuRequested() // Indicate change to state machine
          }, label: {
            Label("Show Options Menu", systemImage: "info.circle")
          })
          .sheet(isPresented: $showPopover, onDismiss: {
              AppController.shared.mainScreenRequested() // Indicate change to state machine
          }) {
              buildPopoverView() // Build popover UI
          }
        */
        }
  }
}


extension ContentView: ContentViewController {
    func displayRecordingUI() {
        
    }
    
    func displayMainScreen() {
        print("Main screen")
    }
    
    func displayOptionsMenu() {
        popoverViewWrapper.popoverUI = .optionsMenu
        print("Options menu screen")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
