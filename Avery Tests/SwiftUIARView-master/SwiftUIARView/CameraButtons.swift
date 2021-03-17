//
//  CameraButtons.swift
//  SwiftUIARView
//
//  Created by Avery Clowes on 3/8/21.
//  Copyright © 2021 Sarang Borude. All rights reserved.
//

import SwiftUI

struct CameraButtons: View {
    var body: some View {
        let iconsize = 30
        let roundButtonFrameSize = 40
        let buttonOpacity = 0.8
        //let buttonColor = "Color.black"
        
        VStack(alignment: .leading){
            HStack{
                Button(action: {}){
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
