//
//  EyeWitnessItemView.swift
//  CITRARB
//
//  Created by Richard Uzor on 16/09/2023.
//

import SwiftUI
import CachedAsyncImage


struct EyeWitnessItemView: View {
    let eyeWitnessItem: EyeWitnessReport
    
    var body: some View {
        HStack{
            //use the cachedasyncimage library to load and cache the news image from the url
            CachedAsyncImage(url: URL(string: "\(BASE_NORMAL_URL)\(eyeWitnessItem.images.first ?? "default.jpg")"),
                             transaction: Transaction(animation: .easeInOut)){ phase in
                //set an animation to display the placeholder image
                if let image = phase.image{
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .transition(.opacity)
                        .frame(width: 120, height: 240)
                        .padding(4)
                }else{
                    HStack{
                        ProgressView()
                    }
                    
                }
            }
            VStack{
                Text(eyeWitnessItem.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading).padding(4)
                
                Text(eyeWitnessItem.location)
                    .fontWeight(.regular)
                    .frame(maxWidth: .infinity, alignment: .leading).padding(4)
                
                //                Text(productItem.userId.username)
                //                    .fontWeight(.regular)
                //                    .frame(maxWidth: .infinity, alignment: .leading).padding(4)
                //
                
            }
            .padding()
        }
    }
}

//struct EyeWitnessItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        EyeWitnessItemView()
//    }
//}
