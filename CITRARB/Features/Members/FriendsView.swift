//
//  FriendsView.swift
//  CITRARB
//
//  Created by Richard Uzor on 23/08/2023.
//

import SwiftUI

struct FriendsView: View {
    
    @StateObject private var viewModel = MembersViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                if viewModel.isLoading == false{
                        ScrollView(.horizontal, showsIndicators: false) {
                                
                        if let pendingFriendRequests = viewModel.pendingFriendRequestsListResponse{
                            HStack(spacing: 20) {
                                // Display the fetched data
                                ForEach(pendingFriendRequests.data, id: \._id){ friendRequestItem in
                                    
                                    FriendRequestItemView(friendRequester: friendRequestItem.requester, pendingFriendRequest: friendRequestItem)
                                        .cornerRadius(30)
                                        .shadow(color: .gray,radius: 8)
                                        .frame(height: 100)
                                       
                                    //                                        .onTapGesture {
                                    //                                        viewModel.isShowingMemberItem = true
                                    //                                            viewModel.selectedMemberItem = IdentifiableMemberListItem(id: memberItem._id, memberItem: memberItem)
                                    //                                    }
                                }
                                
                            }
                            //                        .sheet(item: $viewModel.selectedMemberItem){ identifiableMemberListItem in
                            //                            MemberSheetView(memberItem: identifiableMemberListItem.memberItem)
                            //                        }
                            .refreshable {
                                viewModel.fetchFriendsListData()
                            }
                        }
                    }
                    //.padding()
                    //.frame(height: 240)
                    
                    VStack{
                        //            Image("bgDay")
                        //              .aspectRatio(contentMode: .fill)
                        //              .opacity(0.5)
                        
                        if let friendsList = viewModel.friendsListResponse{
                            List{
                                // Display the fetched data
                                ForEach(friendsList.data, id: \._id){ friendItem in
                                    
                                    FriendsListItemView( userImageUrl: friendItem.friend.photo, userName: friendItem.friend.username)
                                        .swipeActions{
                                            Button{
                                                let phoneNumber = "08132665650"
                                                if let url = URL(string: "tel://\(phoneNumber)") {
                                                    if UIApplication.shared.canOpenURL(url) {
                                                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                                    } else {
                                                        // Handle error: Device doesn't support phone calls or URL is invalid
                                                    }
                                                }
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
                                    //                                        .onTapGesture {
                                    //                                        viewModel.isShowingMemberItem = true
                                    //                                            viewModel.selectedMemberItem = IdentifiableMemberListItem(id: memberItem._id, memberItem: memberItem)
                                    //                                    }
                                }
                                
                            }
                            //                        .sheet(item: $viewModel.selectedMemberItem){ identifiableMemberListItem in
                            //                            MemberSheetView(memberItem: identifiableMemberListItem.memberItem)
                            //                        }
                            .refreshable {
                                viewModel.fetchFriendsListData()
                            }
                        }
                        
                        
                    }//ZStack
                    
                }//if not loading
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
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
