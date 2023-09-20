//
//  UploadsLandingView.swift
//  CITRARB
//
//  Created by Richard Uzor on 17/09/2023.
//

import SwiftUI
import SlidingTabView


struct UploadsLandingView: View {
    @State private var tabIndex = 0

    var body: some View {
        NavigationView{
            VStack{
                SlidingTabView(selection: $tabIndex, tabs: ["Products", "Music", "Reports", "Events"], animation: .easeInOut, activeAccentColor: UPLOADS_COLOR, selectionBarColor: UPLOADS_COLOR)
                Spacer()
                
                if tabIndex == 0{
                    UploadedProductsView()
                }else if tabIndex == 1{
                    UploadedMusicView()
                }else if tabIndex == 2{
                    UploadedEyeWitnessReports()
                }else if tabIndex == 3{
                    
                }
                
                Spacer()
            }
        }.navigationBarTitle("My Uploads")    }
}

struct UploadsLandingView_Previews: PreviewProvider {
    static var previews: some View {
        UploadsLandingView()
    }
}
