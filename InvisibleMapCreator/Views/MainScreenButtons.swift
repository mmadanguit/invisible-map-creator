//
//  MainScreenButtons.swift
//  InvisibleMapCreator
//
//  Created by Marion Madanguit on 3/19/21.
//

import SwiftUI

struct RectangleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 80, height: 40)
            .padding(5)
            .foregroundColor(.white)
            .font(.system(size: 20))
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .opacity(0.7))
    }
}

struct CircleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: CGFloat(40), height: CGFloat(40))
            .padding(10)
            .foregroundColor(.white)
            .font(.system(size: CGFloat(30)))
            .background(
                Circle()
                    .opacity(0.7))
    }
}

struct MainScreenButtons: View {
    
    @ObservedObject var popoverViewWrapper = GlobalState.shared.popoverViewWrapper // Track changes to popover UI
    @State var showPopover: Bool = false // Track whether popover is showing
    @State var recording = false // Track whether map is currently being recorded
    
    func buildPopoverView() -> some View {
        switch popoverViewWrapper.popoverUI {
        case .optionsMenu:
            return AnyView(SideMenuView())
        case .recordMap:
            return AnyView(Text("Record Map"))
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                // Menu button
                Button(action: {
                    showPopover = true
                    AppController.shared.optionsMenuRequested() // Request options menu in state machine
                }){
                    Text("Menu")
                        .accessibility(label: Text("Options menu"))
                }
                .buttonStyle(RectangleButtonStyle())
                .sheet(isPresented: $showPopover, onDismiss: {
                    AppController.shared.mainScreenRequested() // Request main screen in state machine
                }) {
                    buildPopoverView() // Build popover UI
                }
                
                Spacer()
                
                // Undo button
                Button(action: {}){
                    Image(systemName: "arrow.uturn.backward")
                        .accessibility(label: Text("Undo"))
                }
                .buttonStyle(RectangleButtonStyle())
                // Disable in MainScreen state
                .opacity(0.5)
                .disabled(true)
            }
        
            Spacer()
            
            HStack {
                // Manage locations button
                Button(action: {}){
                    Image(systemName: "line.horizontal.3")
                        .accessibility(label: Text("Manage locations"))
                }
                .buttonStyle(CircleButtonStyle())
                // Disable in MainScreen state
                .opacity(0.5)
                .disabled(true)
                
                Spacer()
                
                // Record map button
                Button(action: {
                    withAnimation {
                        recording = true
                    }
                    AppController.shared.startRecordingRequested() // Request start recording in state machine
                }){
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 6)
                            .foregroundColor(.white)
                            .frame(width: 80, height: 80)

                        RoundedRectangle(cornerRadius: recording ? 8 : 68 / 2)
                            .foregroundColor(.red)
                            .frame(width: recording ? 32 : 68, height: recording ? 32 : 68)
                    }
                    .animation(.linear(duration: 0.2))
                    .accessibility(label: Text("Record map"))
                }
     
                Spacer()
            
                // Add location button
                Button(action: {}){
                    Image(systemName: "plus")
                        .accessibility(label: Text("Add location"))
                }
                .buttonStyle(CircleButtonStyle())
                // Disable in MainScreen state
                .opacity(0.5)
                .disabled(true)
        }
    }
    .padding(20)
}

struct MainScreenButtons_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenButtons()
    }
}
}
