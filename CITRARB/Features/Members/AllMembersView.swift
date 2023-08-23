//
//  AllMembersView.swift
//  CITRARB
//
//  Created by Richard Uzor on 23/08/2023.
//

import SwiftUI

struct AllMembersView: View {
    
    @StateObject private var viewModel = MembersViewModel()

    var body: some View {
        NavigationView{
            ZStack{
                //            Image("bgDay")
                //              .aspectRatio(contentMode: .fill)
                //              .opacity(0.5)
                if viewModel.isLoading == false{
                    if let membersList = viewModel.membersListResponse{
                        List{
                            // Display the fetched data
                            ForEach(membersList.members, id: \._id){ memberItem in
                                
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
        .navigationBarTitle("TV Videos")
    }
}

struct AllMembersView_Previews: PreviewProvider {
    static var previews: some View {
        AllMembersView()
    }
}
