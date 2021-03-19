//
//  CameraButtons.swift
//  InvisibleMapCreator
//
//  Created by Marion Madanguit on 3/19/21.
//

import SwiftUI

struct CameraButtons: View {
    
    @ObservedObject var popoverViewWrapper = GlobalState.shared.popoverViewWrapper // Track changes to popoverUI
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
        let buttonOpacity = 0.8
        //let buttonColor = "Color.black"
        
        VStack(alignment: .leading){
            HStack{
                Button(action: {
                    showPopover = true
                    AppController.shared.optionsMenuRequested() // Indicate change to state machine
                }){
                    Text("Menu")
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .frame(width: 75, height: 40)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(13)
                        .opacity(buttonOpacity)
                        .padding([.top, .leading], 20)
                }
                .sheet(isPresented: $showPopover, onDismiss: {
                    AppController.shared.mainScreenRequested() // Indicate change to state machine
                }) {
                    buildPopoverView() // Build popover UI
                }
                
                Spacer()
                Button(action: {}){
                    Image(systemName: "arrowshape.turn.up.left.fill")
                        .frame(width: 40, height: 40)
                        .background(Color.black)
                        .opacity(buttonOpacity)
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .cornerRadius(13)
                        .padding([.top, .trailing], 15)
                }
            }
            
         
            Spacer()
            HStack{
                Spacer()
                Button(action: {}){
                    Image(systemName: "line.horizontal.3")
                        .foregroundColor(.white)
                        .frame(width: CGFloat(roundButtonFrameSize), height: CGFloat(roundButtonFrameSize))
                        .padding(10)
                        .background(Color.black)
                        .opacity(buttonOpacity)
                        .font(.system(size: CGFloat(iconsize)))
                        .cornerRadius(CGFloat(roundButtonFrameSize))
                }
                Spacer()
                
                Button(action: {}){
                    Image(systemName: "circle.fill")
                        .padding(10)
                        .background(Color.red)
                        .cornerRadius(CGFloat(roundButtonFrameSize))
                        .foregroundColor(.red)
                        .font(.system(size: CGFloat(iconsize)))
                            .padding(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color.gray, lineWidth: 4)
                            )
                }
                
                Spacer()
                
                Button(action: {}){
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .frame(width: CGFloat(roundButtonFrameSize), height: CGFloat(roundButtonFrameSize))
                        .padding(10)
                        .background(Color.black)
                        .opacity(buttonOpacity)
                        .font(.system(size: CGFloat(iconsize)))
                        .cornerRadius(CGFloat(roundButtonFrameSize))
                }
                Spacer()
        }
      
    }
}

struct CameraButtons_Previews: PreviewProvider {
    static var previews: some View {
        CameraButtons()
    }
}
}
