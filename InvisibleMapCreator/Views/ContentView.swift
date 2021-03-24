//
//  ContentView.swift
//  InvisibleMapCreator
//
//  Created by Marion Madanguit on 3/5/21.
//

import SwiftUI

// All the button layouts that will exist over the AR view
enum ButtonLayoutType {
    case mainScreen
    case recordMap
}

// All the view types that will exist as a popover over the main screen
enum PopoverViewType {
    case optionsMenu
    case recordMap
}

// Announce any changes that occur to the button UI
class ButtonLayoutTypeWrapper: ObservableObject {
    @Published var buttonUI: ButtonLayoutType
    
    public init() {
        buttonUI = .mainScreen
    }
}

// Announce any changes that occur to the popover UI
class PopoverViewTypeWrapper: ObservableObject {
    @Published var popoverUI: PopoverViewType
    
    public init() {
        popoverUI = .recordMap
    }
}

// Store view wrappers outside of view struct
class GlobalState {
    public static var shared = GlobalState()
    var buttonLayoutWrapper = ButtonLayoutTypeWrapper()
    var popoverViewWrapper = PopoverViewTypeWrapper()
    
    private init() {
        
    }
}

// ARView struct
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
    @ObservedObject var buttonLayoutWrapper = GlobalState.shared.buttonLayoutWrapper // Track changes to buttons UI
    @ObservedObject var popoverViewWrapper = GlobalState.shared.popoverViewWrapper // Track changes to popover UI
    
    init() {
        AppController.shared.contentViewer = self
    }
    
    func buildButtonLayout() -> some View {
        switch buttonLayoutWrapper.buttonUI {
        case .mainScreen:
            return AnyView(MainScreenButtons())
        case .recordMap:
            return AnyView(RecordMapButtons())
        }
    }
    
    var body: some View {
        ZStack {
          NavigationIndicator().edgesIgnoringSafeArea(.all)
          buildButtonLayout()
        }
    }
}

extension ContentView: ContentViewController {
    func displayRecordingUI() {
        buttonLayoutWrapper.buttonUI = .recordMap
    }
    
    func displayMainScreen() {
        buttonLayoutWrapper.buttonUI = .mainScreen
    }
    
    func displayOptionsMenu() {
        popoverViewWrapper.popoverUI = .optionsMenu
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
