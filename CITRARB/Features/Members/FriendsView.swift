//
//  FriendsView.swift
//  CITRARB
//
//  Created by Richard Uzor on 23/08/2023.
//

import SwiftUI

struct FriendsView: View {
    
    @StateObject private var viewModel = MembersViewModel()
    @State private var searchText = ""

    
    var body: some View {
        NavigationView{
            VStack{
                if viewModel.isLoading == false{
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        if let pendingFriendRequests = viewModel.pendingFriendRequestsListResponse{
                            HStack(spacing: 20) {
                                // Display the fetched data
                                displayPendingFriendRequests(pendingFriendRequests: pendingFriendRequests)
                            }
                        }
                    }
                    VStack{
                        SearchBarView(text: $searchText)
                        
                        if let friendsList = viewModel.friendsListResponse{
                            let filteredMembers = friendsList.data.filter { friendItem in
                                return searchText.isEmpty || friendItem.friend .username.localizedCaseInsensitiveContains(searchText)
                            }
                            List{
                                // Display the fetched data
                                ForEach(filteredMembers, id: \._id){ friendItem in
                                    
                                    displayFriends(friendList: friendItem)
                                }
                                
                            }
                            .refreshable {
                                viewModel.fetchFriendsListData()
                            }
                        }
                    } //VStack
                    
                } //if not loading
                else {
                    // Show a loading view or error message while data is being fetched
                    VStack{
                        LottieView(filename: "loading")
                            .frame(width: 120,  height: 120)
                    }
                    
                }
    }
}
    .onAppear{
        viewModel.fetchFriendsListData()
    }
    .navigationBarTitle("Members")
}

func makeCall(){
    let phoneNumber = "08132665650"
    if let url = URL(string: "tel://\(phoneNumber)") {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            // Handle error: Device doesn't support phone calls or URL is invalid
        }
    }
}

func displayFriends(friendList: FriendsList) -> some View{
        
    FriendsListItemView( userImageUrl: friendList.friend.photo, userName: friendList.friend.username)
            .swipeActions{
                Button{
                    makeCall()
                }label: {
                    Label("Call", systemImage: "phone")
                }
                .tint(.green)
            }
            .swipeActions{
                Button{
                    
                }label: {
                    Label("Message", systemImage: "message")
                }
                .tint(.blue)
            }
            .swipeActions(edge: .leading){
                Button{
                    //ask for confirmation
                    //delete friend
                }label: {
                    Label("Unfriend", systemImage: "person.fill.badge.minus")
                }
                .tint(.red)

            }

    
}

func displayPendingFriendRequests(pendingFriendRequests: PendingFriendRequestsResponse) -> some View{
    ForEach(pendingFriendRequests.data, id: \._id){ friendRequestItem in
        
        FriendRequestItemView(friendRequester: friendRequestItem.requester, pendingFriendRequest: friendRequestItem)
            .cornerRadius(30)
            .shadow(color: .gray,radius: 8)
            .frame(height: 100)
            .refreshable {
                viewModel.fetchFriendsListData()
            }
    }
    
}
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
