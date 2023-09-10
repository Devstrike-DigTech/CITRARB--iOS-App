//
//  ConnectViewModel.swift
//  CITRARB
//
//  Created by Richard Uzor on 17/07/2023.
//

import Foundation

class ConnectsViewModel: ObservableObject{
    
    @Published var connectsListResponse: ConnectResponse?
    @Published var connectsList: [Connect]?
    @Published var medicalConnectsList: [Connect]?
    @Published var serviceConnectsList: [Connect]?
    @Published var techConnectsList: [Connect]?
    @Published var occupationList: [String]?
    @Published var isLoading: Bool = false
    @Published var selectedConnectItem: IdentifiableConnectListItem? // Added
    @Published var isShowingConnectItem: Bool = false
    @Published var showingNewItemView = false
    @Published var showAlert = false
    @Published var canCreateOccupation = false
    @Published var error: String?
    @Published var jobTitle = ""
    @Published var description = ""
    @Published var phone = ""
    @Published var name = ""
    @Published var category = ""
    let tag: String = ""
    
    
    
    private var apiClient = ConnectAPIClient()
    
    
    func fetchConnectsList() {
        isLoading = true
        apiClient.fetchConnectsList { result in
            switch result {
            case .success(let connectsListResponse):
                DispatchQueue.main.async {
                    self.isLoading = false
                    let updatedData = connectsListResponse
                    
                    self.connectsListResponse = updatedData
                    self.medicalConnectsList = updatedData.data.filter{ occupation in
                        return occupation.category == "Medical"
                    }
                    self.serviceConnectsList = updatedData.data.filter{ occupation in
                        return occupation.category == "Service"
                    }
                    self.techConnectsList = updatedData.data.filter{ occupation in
                        return occupation.category == "Tech"
                    }
                    self.connectsList = updatedData.data
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
    
    func createNewConnect(){
        isLoading = true
        guard canSave() else{
            return
        }
        apiClient.createNewConnect(jobTitle: jobTitle, description: description, phone: phone, name: name, category: category){ result in
            DispatchQueue.main.async {
                switch result{
                case .success(let response):
                    print("SUCCESS: \(response)")
                    self.showingNewItemView = false
                    
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
    
    
    
    
    public func canSave() -> Bool{
        
        let descriptionCharCount = description.filter {$0 != " "}.count
        let phoneNumberCharCount = phone.filter {$0 != " "}.count
        
        print("\(descriptionCharCount)")
        
        
        guard !jobTitle.trimmingCharacters(in: .whitespaces).isEmpty else{
            error = "Please enter job title."
            showAlert = true
            return false
        }
        guard descriptionCharCount > 25 else{
            error = "Job description requires minimum of 25 characters."
            showAlert = true
            return false
        }
        guard phoneNumberCharCount != 11 else{
            error = "Phone number should have 11 characters."
            showAlert = true
            return false
        }
        
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else{
            error = "Please enter your name."
            showAlert = true
            return false
        }
        guard !category.trimmingCharacters(in: .whitespaces).isEmpty else{
            error = "Please select your job category."
            showAlert = true
            return false
        }
        
        
        return true
    }
}


