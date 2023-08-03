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
    
    @Published var token: String?
    @Published var error: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    
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
    
    func register(){
        
    }
}
