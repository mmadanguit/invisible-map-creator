//
//  RecordMapButtons.swift
//  InvisibleMapCreator
//
//  Created by Marion Madanguit on 3/23/21.
//

import SwiftUI

struct RecordMapButtons: View {
    
    @State var recording = true // Track whether map is currently being recorded
    
    var body: some View {
        VStack {
            HStack {
                // Menu button
                Button(action: {}){
                    Text("Menu")
                        .accessibility(label: Text("Options menu"))
                }
                .buttonStyle(RectangleButtonStyle())
                // Disable in RecordMap state
                .opacity(0.5)
                .disabled(true)
                
                Spacer()
                
                // Undo button
                Button(action: {}){
                    Image(systemName: "arrow.uturn.backward")
                        .accessibility(label: Text("Undo"))
                }
                .buttonStyle(RectangleButtonStyle())
            }
        
            Spacer()
            
            HStack {
                // Manage locations button
                Button(action: {}){
                    Image(systemName: "line.horizontal.3")
                        .accessibility(label: Text("Manage locations"))
                }
                .buttonStyle(CircleButtonStyle())
                
                Spacer()
                
                // Record map button
                Button(action: {
                    withAnimation {
                        recording = false
                    }
                    AppController.shared.stopRecordingRequested() // Request start recording in state machine
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
        }
    }
    .padding(20)
}

struct RecordMapButtons_Previews: PreviewProvider {
    static var previews: some View {
        RecordMapButtons()
    }
}
}
