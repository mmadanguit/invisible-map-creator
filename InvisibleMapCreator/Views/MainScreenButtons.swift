//
//  MainScreenButtons.swift
//  InvisibleMapCreator
//
//  Created by Marion Madanguit on 3/19/21.
//

import SwiftUI

struct MainScreenButtons: View {
    
    @ObservedObject var popoverViewWrapper = GlobalState.shared.popoverViewWrapper // Track changes to popover UI
    @State var showPopover: Bool = false // Track whether popover is showing
    
    func buildPopoverView() -> some View {
        switch popoverViewWrapper.popoverUI {
        case .optionsMenu:
            return AnyView(SideMenuView())
        case .recordMap:
            return AnyView(Text("Record Map"))
        }
    }
    
    var body: some View {
        
        let iconsize = 30
        let roundButtonFrameSize = 40
        let buttonOpacity = 0.7
//      let buttonColor = Color.blue
        
        VStack(alignment: .leading){
            HStack{
                Button(action: {
                    showPopover = true
                    AppController.shared.optionsMenuRequested() // Indicate change to state machine
                }){
                    Text("Menu") // Menu button
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .frame(width: 75, height: 40)
                        .foregroundColor(.white)
                }
                .background(RoundedRectangle(cornerRadius: 13).opacity(buttonOpacity))
                        .padding([.top, .leading], 20)
                        
                .sheet(isPresented: $showPopover, onDismiss: {
                    AppController.shared.mainScreenRequested() // Indicate change to state machine
                }) {
                    buildPopoverView() // Build popover UI
                }
                .disabled(true)
                
                Spacer()
                Button(action: {}){
                    Image(systemName: "arrowshape.turn.up.left.fill")
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                }
                .background(RoundedRectangle(cornerRadius: 13).opacity(buttonOpacity))
                    .padding([.top, .trailing], 20)
            }
            
         
            Spacer()
            HStack{ // Button bar
                Spacer()
                Button(action: {}){
                    Image(systemName: "line.horizontal.3") // List of POIs
                        .foregroundColor(.white)
                        .frame(width: CGFloat(roundButtonFrameSize), height: CGFloat(roundButtonFrameSize))
                        .padding(10)
                        .font(.system(size: CGFloat(iconsize)))
                }
                .background(Circle().opacity(buttonOpacity))
                Spacer()
                
                Button(action: {
                    AppController.shared.startRecordingRequested() // Indicate change to state machine
                }){
                    Image(systemName: "circle.fill") // Record button image
                        .padding(10) // padding around image
                        .background(Color.red) //color of shape behind image
                        .cornerRadius(CGFloat(roundButtonFrameSize))
                        .foregroundColor(.red) //color of shape
                        .font(.system(size: CGFloat(iconsize)))//size of shape
                        .padding(5) //padding between red circle and white circle
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.white, lineWidth: 4)//white circle
                        )
                }
                Spacer()
            
                Button(action: {}){
                    Image(systemName: "plus") // Add POI button
                        .foregroundColor(.white)
                        .frame(width: CGFloat(roundButtonFrameSize), height: CGFloat(roundButtonFrameSize))
                        .padding(10)
                        .font(.system(size: CGFloat(iconsize)))
                }
                .background(Circle().opacity(buttonOpacity))
                Spacer()
        }
      
    }
}

struct MainScreenButtons_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenButtons()
    }
}
}
