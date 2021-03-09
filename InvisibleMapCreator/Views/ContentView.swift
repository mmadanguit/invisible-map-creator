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
    var popoverViewWrapper = PopoverViewTypeWrapper()
    public static var shared = GlobalState()
    
    private init() {
        
    }
}

struct ContentView: View {
    
    @ObservedObject var popoverViewWrapper = GlobalState.shared.popoverViewWrapper // Track changes to popoverUI
    @State var showPopover: Bool = false // Track whether popover is showing
    
    init() {
        AppController.shared.contentViewer = self
    }
    
    func buildPopoverView() -> some View {
        switch popoverViewWrapper.popoverUI {
        case .optionsMenu:
            return AnyView(SideMenuView())
        case .recordMap:
            return AnyView(Text("Record Map"))
        }
    }
    
    var body: some View {

        VStack(spacing: 50) {
          Text("Main View")
            .font(.largeTitle)
          
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
