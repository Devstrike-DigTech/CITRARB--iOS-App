//
//  AllMembersView.swift
//  CITRARB
//
//  Created by Richard Uzor on 23/08/2023.
//

import SwiftUI

struct AllMembersView: View {
    
    @StateObject private var viewModel = MembersViewModel()
    @State private var searchText = ""
    
    
    var body: some View {
        NavigationView{
            ZStack{
                //            Image("bgDay")
                //              .aspectRatio(contentMode: .fill)
                //              .opacity(0.5)
                if viewModel.isLoading == false{
                    VStack{
                        SearchBarView(text: $searchText)
                        if let membersList = viewModel.membersListResponse{
                            let filteredMembers = membersList.members.filter { memberItem in
                                return searchText.isEmpty || memberItem.username.localizedCaseInsensitiveContains(searchText)
                            }
                            
                            List{
                                // Display the fetched data
                                ForEach(filteredMembers, id: \._id){ memberItem in
                                    
                                    AllMembersListItemView( userImageUrl: memberItem.photo, userName: memberItem.username,
                                                            userGender: memberItem.role)
                                    .onTapGesture {
                                        viewModel.isShowingMemberItem = true
                                        viewModel.selectedMemberItem = IdentifiableMemberListItem(id: memberItem._id, memberItem: memberItem)
                                    }
                                }
                                
                            }
                            .sheet(item: $viewModel.selectedMemberItem){ identifiableMemberListItem in
                                MemberSheetView(memberItem: identifiableMemberListItem.memberItem)
                            }
                            .refreshable {
                                viewModel.fetchMembersListData()
                            }
                        }
                    }
                    
                    
                }
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
            viewModel.fetchMembersListData()
        }
        .navigationBarTitle("Members")
    }
}

struct AllMembersView_Previews: PreviewProvider {
    static var previews: some View {
        AllMembersView()
    }
}
