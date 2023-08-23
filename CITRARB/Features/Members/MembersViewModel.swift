//
//  MembersViewModel.swift
//  CITRARB
//
//  Created by Richard Uzor on 17/07/2023.
//

import Foundation

class MembersViewModel: ObservableObject{
    
    @Published var membersListResponse: MembersListResponse?
    @Published var isLoading: Bool = true
    @Published var selectedMemberItem: IdentifiableMemberListItem? // Added
    @Published var isShowingMemberItem: Bool = false


    
    private var apiClient = MembersAPIClient()
    
    
    func fetchMembersListData() {
        apiClient.fetchMembersList { result in
            switch result {
            case .success(let membersListResponse):
                DispatchQueue.main.async {
                    self.isLoading = false
                    let updatedData = membersListResponse
                    self.membersListResponse = updatedData
//                        .members.map { item in
//                        var updatedItem = item
//
//                        return updatedItem
//                    }
//                    self.membersListResponse = MembersListResponse(members: updatedData, status: membersListResponse.status)
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
                self.isLoading = false
                // Handle error (e.g., show an alert)
                
            }
        }
    }
}
