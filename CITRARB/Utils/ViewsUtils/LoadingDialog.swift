//
//  LoadingDialog.swift
//  CITRARB
//
//  Created by Richard Uzor on 07/09/2023.
//

import SwiftUI

struct LoadingDialog: View {
    
    let isLoading: Bool
    var body: some View {
        
        GeometryReader { geometry in
              VStack {
                  Spacer() // Push content to the top

                  if isLoading == true{
                      VStack{
                          LottieView(filename: "loading")
                              .frame(width: 120,  height: 120)
                      }
                      .frame(width: geometry.size.width * 0.8) // Set the desired width
                      .padding() // Add padding
                      
                  }
                  Spacer() // Push content to the bottom
              }
              .frame(maxWidth: .infinity, maxHeight: .infinity)
              .background(Color.white) // Optional, set the background color
              .ignoresSafeArea() // Use this to cover the status bar if needed
          }
       
    }
}

struct LoadingDialog_Previews: PreviewProvider {
    static var previews: some View {
        LoadingDialog(isLoading: true)
    }
}
