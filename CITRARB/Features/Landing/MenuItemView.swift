//
//  MenuItemView.swift
//  CITRARB
//
//  Created by Richard Uzor on 18/07/2023.
//

import SwiftUI
import Lottie

struct MenuItemView: View {
    
    let animation: String
    
    var body: some View {
        ZStack{
            LottieView(filename: animation)
                        
        }
        .frame(width: 120, height: 130)
        .cornerRadius(30)
        .shadow(radius: 30)
    }
}

struct MenuItemView_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemView(animation: "citrarb_market_place_menu")
    }
}
