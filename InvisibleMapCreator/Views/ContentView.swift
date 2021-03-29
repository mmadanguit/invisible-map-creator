//
//  ContentView.swift
//  InvisibleMapCreator
//
//  Created by Marion Madanguit on 3/5/21.
//

import SwiftUI

// All the view types that will exist as a popover over the main screen
enum PopoverViewType {
    case optionsMenu
    case recordMap
}

// Announce any changes that occur to the popover UI
class PopoverViewTypeWrapper: ObservableObject {
    @Published var popoverUI: PopoverViewType
    
    public init() {
        popoverUI = .recordMap
    }
}

// Store view wrappers and state variables outside of view struct
class GlobalState {
    public static var shared = GlobalState()
    var popoverViewWrapper = PopoverViewTypeWrapper()
    var recording: Bool // Button layout parameter
    
    private init() {
        recording = false
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
    @ObservedObject var popoverViewWrapper = GlobalState.shared.popoverViewWrapper // Track changes to popover UI
    @State var recording = GlobalState.shared.recording // Track whether map is currently being recorded
    
    init() {
        AppController.shared.contentViewer = self
    }
    

    var body: some View {
        ZStack {
          NavigationIndicator().edgesIgnoringSafeArea(.all)
            ButtonLayout(recording: $recording)
        }
    }
}

extension ContentView: ContentViewController {
    func displayRecordingUI() {
        /*recording = true
        print("recording: \(recording)")*/
    }
    
    func displayMainScreen() {
        /*recording = false
        print("recording: \(recording)")*/
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
