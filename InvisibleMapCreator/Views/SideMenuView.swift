//
//  SideMenuView.swift
//  InvisibleMapCreator
//
//  Created by Marion Madanguit on 2/22/21.
//

import SwiftUI

struct SideMenuView: View {
    var body: some View {
        ZStack {
            VStack {
                // Header
                HStack {
                    Text("Menu")
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                }
                
                // Side Menu Content
                ForEach(SideMenuViewModel.allCases, id:\.self) { option in
                    SideMenuOptionView(viewModel: option)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}
