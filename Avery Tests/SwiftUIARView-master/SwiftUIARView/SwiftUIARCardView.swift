//
//  SwiftUIARView.swift
//  SwiftUIARView
//
//  Created by Avery Clowes on 3/5/21.
//
//

import SwiftUI

struct SwiftUIARCardView: View {
    @State private var textToShow = "April Tag"
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.black, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(textToShow)
                    .foregroundColor(.white)
                    .bold().font(.title)
                Button(action: {
                    self.textToShow = "Button Tapped!"
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .frame(width: 150, height: 50)
                        Text("Click Here")
                    }
                }
            }
        }
    }
}

struct SwiftUIARCardView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIARCardView()
    }
}
