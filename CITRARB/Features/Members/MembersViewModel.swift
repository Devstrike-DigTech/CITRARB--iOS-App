//
//  MembersViewModel.swift
//  CITRARB
//
//  Created by Richard Uzor on 17/07/2023.
//

import Foundation

class MembersViewModel: ObservableObject{
    
    @Published var membersListResponse: MembersListResponse?
    @Published var friendsListResponse: GetFriendsResponse?
    @Published var pendingFriendRequestsListResponse: PendingFriendRequestsResponse?
    @Published var isLoading: Bool = true
    @Published var selectedMemberItem: IdentifiableMemberListItem? // Added
    @Published var isShowingMemberItem: Bool = false
    @Published var error: String?


    
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
    
    func sendFriendRequest(userId: String){
        isLoading = true
        MembersAPIClient.sendFriendRequest(userId: userId){ result in
            DispatchQueue.main.async {
                switch result{
                case .success(let response):
                    print("SUCCESS: \(response)")
                case .failure(let error):
                    switch error {
                    case .networkError(let networkError):
                        print("NETWORK ERROR: \(networkError)")
                        self.error = "Check your internet connection"
                        // Handle network error
                    case .noData:
                        print("NO DATA ERROR")
                        // Handle no data error
                    case .decodingError(let decodingError):
                        print("DECODING ERROR: \(decodingError)")
                        // Handle decoding error
                        
                    }
                }
                
            }
        }
        
    }
    
    func fetchFriendsListData() {
        apiClient.fetchFriendsList { result in
            switch result {
            case .success(let friendsListResponse):
                DispatchQueue.main.async {
                    
                    let updatedData = friendsListResponse//.data.map { item -> FriendsList in
//                        var updatedItem = item
//
//                        return updatedItem
//                    }
                    self.friendsListResponse = updatedData//GetFriendsResponse(status: friendsListResponse.status, length: friendsListResponse.length, //data: updatedData)
//                        .members.map { item in
//                        var updatedItem = item
//
//                        return updatedItem
//                    }
//                    self.membersListResponse = MembersListResponse(members: updatedData, status: membersListResponse.status)
                    self.fetchPendingFriendRequestsList()
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
                self.isLoading = false
                // Handle error (e.g., show an alert)
                
            }
        }
    }
    
    
    func fetchPendingFriendRequestsList() {
        apiClient.fetchPendingFriendRequestsList { result in
            switch result {
            case .success(let pendingFriendRequestsListResponse):
                DispatchQueue.main.async {
                    self.isLoading = false
                    let updatedData = pendingFriendRequestsListResponse//.data.map { item -> FriendsList in
//                        var updatedItem = item
//
//                        return updatedItem
//                    }
                    self.pendingFriendRequestsListResponse = updatedData//GetFriendsResponse(status: friendsListResponse.status, length: friendsListResponse.length, //data: updatedData)
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
    
    func respondToFriendRequestsList(requestId: String, status: String){
        isLoading = true
        MembersAPIClient.respondToFriendRequestsList(requestId: requestId, status: status){ result in
            DispatchQueue.main.async {
                switch result{
                case .success(let response):
                    print("SUCCESS: \(response)")
                    self.fetchFriendsListData()
                case .failure(let error):
                    switch error {
                    case .networkError(let networkError):
                        print("NETWORK ERROR: \(networkError)")
                        self.error = "Check your internet connection"
                        // Handle network error
                    case .noData:
                        print("NO DATA ERROR")
                        // Handle no data error
                    case .decodingError(let decodingError):
                        print("DECODING ERROR: \(decodingError)")
                        // Handle decoding error
                        
                    }
                }
                
            }
        }
        
    }
    
}
