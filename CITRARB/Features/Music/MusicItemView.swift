//
//  MusicItemView.swift
//  CITRARB
//
//  Created by Richard Uzor on 13/09/2023.
//

import SwiftUI
import CachedAsyncImage


struct MusicItemView: View {
    let musicItem: Music
    
    var body: some View {
        HStack{
            //use the cachedasyncimage library to load and cache the news image from the url
            CachedAsyncImage(url: URL(string: "\(BASE_NORMAL_URL)\(musicItem.image)"),
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
                Text(musicItem.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading).padding(4)
                
                Text(musicItem.userId.username)
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

struct MusicItemView_Previews: PreviewProvider {
    static var previews: some View {
        MusicItemView(musicItem: Music(_id: "123", file: "https://pixabay.com/music/meditationspiritual-ambient-relaxing-music-for-you-15969/", title: "Music Title", userId: MusicOwner(_id: "123", username: "Davido", email: "davido@email.com", role: "user", photo: "https://citrab.onrender.com/music-cover--16866649712495016.jpeg", phone: "08132665650", gender: "Male", createdAt: "12-08-2023", updatedAt: "12-08-2023", __v: 1), description: "Music Description", isVerified: false, image: "Whi ompice dt ratiner", createdAt: "12-89-203", updatedAt: "12-89-2003", reactions: ["String"], id: "123"))
    }
}
