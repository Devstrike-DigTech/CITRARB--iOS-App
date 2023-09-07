//
//  MemberSheetView.swift
//  CITRARB
//
//  Created by Richard Uzor on 24/08/2023.
//

import SwiftUI
import CachedAsyncImage


struct MemberSheetView: View {
    
    let memberItem: Member
    @StateObject private var viewModel = MembersViewModel()


    var body: some View {
        VStack{
            //use the cachedasyncimage library to load and cache the news image from the url
            CachedAsyncImage(url: URL(string: memberItem.photo),
                             transaction: Transaction(animation: .easeInOut)){ phase in
                //set an animation to display the placeholder image
                if let image = phase.image{
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .transition(.opacity)
                        .frame(maxWidth: .infinity)
                        .frame(height: 240)
                }else{
                    HStack{
                        Image(systemName: "photo.fill")
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 240))
                            //.resizable()
                            .scaledToFit()
                        //ProgressView()
                    }
                    
                }
            }
            Text("\(memberItem.username)")
                .fontWeight(.bold)
            Text("\(memberItem.email)")
                .fontWeight(.regular)
                .frame(alignment: .leading)
            Text("\(memberItem.role)")
                .fontWeight(.regular)
                .frame(alignment: .leading)
            
            Button("Send Friend Request"){
                print("will send friend request from viewmodel function")
                viewModel.sendFriendRequest(userId: memberItem._id)
            }
            .tint(MEMBERS_COLOR)
            .padding()
        }
        Spacer()
    }
}

struct MemberSheetView_Previews: PreviewProvider {
    static var previews: some View {
        MemberSheetView(memberItem: Member(_id: "123", username: "Username", email: "email", role: "user", photo: "https://fastly.picsum.photos/id/9/5000/3269.jpg?hmac=cZKbaLeduq7rNB8X-bigYO8bvPIWtT-mh8GRXtU3vPc", createdAt: "time", updatedAt: "time", __v: 0))
    }
}
