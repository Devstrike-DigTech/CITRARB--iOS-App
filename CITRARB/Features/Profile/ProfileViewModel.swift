//
//  ProfileViewModel.swift
//  CITRARB
//
//  Created by Richard Uzor on 17/07/2023.
//

import Foundation
import Combine


class ProfileViewModel: ObservableObject{
    
    @Published var isLoading: Bool = true
    @Published var isShowingLogin: Bool = false
    @Published var isShowingRegister: Bool = false
    @Published var isCallSuccess: Bool = false
    
    @Published var userProfileResponse: GetMeResponse?

    
    @Published var token: String?
    @Published var error: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    private var apiClient = AuthService()

    
    
    func login(email: String, password: String){
        isLoading = true
        AuthService.login(email: email, password: password){ result in
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
    
    func register(username: String, email: String, password: String, confirmPassword: String){
        isLoading = true
        guard validate(userName: username, email: email, password: password, confirmPassword: confirmPassword) else{
            return
        }
        AuthService.register(username: username, email: email, password: password, confirmPassword: confirmPassword){ result in
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
    
    func fetchUserProfile() {
        isLoading = true
       
        apiClient.fetchUserProfile() { result in
            switch result {
            case .success(let userProfileResponse):
                DispatchQueue.main.async {
                    self.isLoading = false
                    let updatedData = userProfileResponse
                    self.userProfileResponse = updatedData
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
    
    
    func deleteMe() {
        
        apiClient.deleteMe { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.isCallSuccess = true
                    self.isLoading = !self.isCallSuccess
                    //let updatedData = musicListResponse
                    //self.musicListResponse = updatedData
                    //                        .members.map { item in
                    //                        var updatedItem = item
                    //
                    //                        return updatedItem
                    //                    }
                    //                    self.membersListResponse = MembersListResponse(members: updatedData, status: membersListResponse.status)
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
                self.error = "\(error)"
                self.isLoading = false
                // Handle error (e.g., show an alert)
                
            }
        }
        
    }
    
    
    
    
    private func validate(userName: String, email: String, password: String, confirmPassword: String) -> Bool{
        
        guard email.contains("@") && email.contains("@") else{
            error = "Please enter valid email."
            return false
        }
        
        guard !userName.trimmingCharacters(in: .whitespaces).isEmpty, !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else{
            error = "Please fill out all fields."
            return false
        }
        
        guard password.count >= 6 else{
            error = "Password must be at least 6 characters"
            return false
        }
        
        guard password == confirmPassword else{
            error = "Password does not match."
            return false
        }
        
        return true
    }
}
