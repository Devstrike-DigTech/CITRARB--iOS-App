//
//  TVListItemView.swift
//  CITRARB
//
//  Created by Richard Uzor on 19/07/2023.
//

import SwiftUI
import CachedAsyncImage

struct TVListItemView: View {
    
    let videoThumbnail: String
    let videoTitle: String
    
    
    var body: some View {
        //NavigationView{
            HStack{
                CustomURLImage(urlString: videoThumbnail)
                    .frame(width: 130, height: 70)
                Text(videoTitle)
                    .font(.subheadline)
                    .padding(4)
            }
            Spacer()
            //.frame(height: 100)
            .cornerRadius(30)
            .shadow(color: TV_COLOR,radius: 1)
            //.padding()
            //.padding()
        
        
    }
}

            
                //use the cachedasyncimage library to load and cache the news image from the url
                
//                CachedAsyncImage(url: URL(string: videoThumbnail),
//                                 transaction: Transaction(animation: .easeInOut)){ phase in
//                    //set an animation to display the placeholder image
//                    if let image = phase.image{
//                        image
//                            .resizable()
//                            .scaledToFit()
//                            .clipShape(RoundedRectangle(cornerRadius: 20))
//                            .transition(.opacity)
//                            .frame(width: 120, height: 70)
//
//
//                    }else{
//                        HStack{
//                            ProgressView()
//                        }
//
//                    }
//                }.frame(alignment: .leading)
//
////
                
             
            
       // }
        

struct TVListItemView_Previews: PreviewProvider {
    static var previews: some View {
        TVListItemView( videoThumbnail: "https://i.ytimg.com/vi/OwgHmfRvIcM/default.jpg", videoTitle: "Video")
    }
}
