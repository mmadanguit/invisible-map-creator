//
//  ContentView.swift
//  InvisibleMapCreator
//
//  Created by Marion Madanguit on 3/5/21.
//

import SwiftUI

class PopoverViewTypeWrapper: ObservableObject {
    @Published var popoverUI: PopoverViewType
    
    public init() {
        popoverUI = .options
    }
}

enum PopoverViewType {
    case options
}

struct ContentView: View {
    
    init() {
        AppController.shared.contentViewer = self
    }
    
    func buildPopoverView() -> some View {
        switch popoverViewWrapper.popoverUI {
        case .options:
            return AnyView(SideMenuView())
        }
    }
    
    @StateObject var popoverViewWrapper = PopoverViewTypeWrapper()
    @State var showPopover: Bool = false
    
    var body: some View {

        VStack(spacing: 50) {
          Text("Main View")
            .font(.largeTitle)
          
          Button(action: {
            showPopover = true
            AppController.shared.optionsMenuRequested()
          }, label: {
            Label("Show Options Menu", systemImage: "info.circle")
          })
        }
        .sheet(isPresented: $showPopover) {
            buildPopoverView()

  }
}
}

extension ContentView: ContentViewController {
    func displayRecordingUI() {
        
    }
    
    func displayMainScreen() {
        
    }
    
    func displayOptionsMenu() {
        popoverViewWrapper.popoverUI = .options
        print("Setting options menu")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
