//
//  FriendRequestItemView.swift
//  CITRARB
//
//  Created by Richard Uzor on 03/08/2023.
//

import SwiftUI
import CachedAsyncImage


struct FriendRequestItemView: View {
//
//    let userImageUrl: String
//    let userName: String
//
    @StateObject private var viewModel = MembersViewModel()

    let friendRequester: FriendRequester
    let pendingFriendRequest: PendingFriendRequest
    
    var body: some View {
        HStack{
            //use the cachedasyncimage library to load and cache the news image from the url
            CachedAsyncImage(url: URL(string: friendRequester.photo),
                             transaction: Transaction(animation: .easeInOut)){ phase in
                //set an animation to display the placeholder image
                if let image = phase.image{
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 360))
                        .transition(.opacity)
                        .frame(width: 40, height: 240)
                }else{
                    HStack{
                        ProgressView()
                    }
                    
                }
            }
                             .padding()
            VStack{
                Text(friendRequester.username)
                    .fontWeight(.bold)
                HStack{
                    Button{
                        print("Accepted")
                        viewModel.respondToFriendRequestsList(requestId: pendingFriendRequest._id, status: "accepted")
                    }label: {
                        Label("", systemImage: "person.fill.checkmark")
                    }.padding()
                        .font(.title)
                        .tint(.green)
                        Button{
                            viewModel.respondToFriendRequestsList(requestId: pendingFriendRequest._id, status: "declined")
                            print("Rejected")
                        }label: {
                            Label("", systemImage: "person.fill.xmark")
                        }
                        .tint(.red)
                        .font(.title)
                }
               
            }
            //.padding()
        }
        
    }
    
}

struct FriendRequestItemView_Previews: PreviewProvider {
    static var previews: some View {
        FriendRequestItemView( friendRequester: FriendRequester(_id: "1233", username: "Friend Requester", photo: "https://fastly.picsum.photos/id/9/5000/3269.jpg?hmac=cZKbaLeduq7rNB8X-bigYO8bvPIWtT-mh8GRXtU3vPc"), pendingFriendRequest: PendingFriendRequest(_id: "123", userId: "user123", requester: FriendRequester(_id: "1233", username: "Friend Requester", photo: "https://fastly.picsum.photos/id/9/5000/3269.jpg?hmac=cZKbaLeduq7rNB8X-bigYO8bvPIWtT-mh8GRXtU3vPc"), status: "success"))
    }
}
