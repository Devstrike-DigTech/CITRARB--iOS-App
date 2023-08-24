//
//  AllMembersListItemView.swift
//  CITRARB
//
//  Created by Richard Uzor on 03/08/2023.
//

import SwiftUI
import CachedAsyncImage


struct AllMembersListItemView: View {
    
    let userImageUrl: String
    let userName: String
    let userGender: String
    
    var body: some View {
        HStack{
            //use the cachedasyncimage library to load and cache the news image from the url
            CachedAsyncImage(url: URL(string: userImageUrl),
                             transaction: Transaction(animation: .easeInOut)){ phase in
                //set an animation to display the placeholder image
                if let image = phase.image{
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 240))
                        .transition(.opacity)
                        .frame(width: 120, height: 240)
                }else{
                    HStack{
                        ProgressView()
                    }
                    
                }
            }
            VStack{
                Text(userName)
                    .fontWeight(.bold)
                Text(userGender)
                    .font(.subheadline)
                    .frame(alignment: .leading)
            }.padding()
        }
        
    }
}

struct AllMembersListItemView_Previews: PreviewProvider {
    static var previews: some View {
        AllMembersListItemView(userImageUrl: "https://fastly.picsum.photos/id/9/5000/3269.jpg?hmac=cZKbaLeduq7rNB8X-bigYO8bvPIWtT-mh8GRXtU3vPc", userName: "Member Name", userGender: "Male")
    }
}
