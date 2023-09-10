//
//  MarketPlaceViewModel.swift
//  CITRARB
//
//  Created by Richard Uzor on 17/07/2023.
//

import Foundation
import UIKit

class MarketPlaceViewModel: NSObject, ObservableObject, URLSessionDelegate{
    
    
    @Published var productsListResponse: GetAllProductsResponse?
    @Published var isLoading: Bool = true
    @Published var selectedProductItem: IdentifiableProductListItem? // Added
    @Published var isShowingProductItem: Bool = false
    @Published var showingNewItemView = false
    @Published var error: String?
    @Published var showAlert = false
    @Published var uploadProgress: Double = 0.0
    @Published var productName = ""
    @Published var productCategory = ""
    @Published var productPrice = ""
    @Published var productDescription = ""
    @Published var selectedFile1: URL? = URL(string: "")
    @Published var selectedFile2: URL? = URL(string: "")
    @Published var selectedFile3: URL? = URL(string: "")

    @Published var uploadProgressHandler: ((Double) -> Void)?


//
//    init(api: MarketPlaceAPIClient) {
//            api.uploadProgressHandler = { [weak self] progress in
//                DispatchQueue.main.async {
//                    self?.uploadProgress = progress
//                }
//            }
//        }


    
    let apiClient = MarketPlaceAPIClient()
    
    
    func fetchProductsList() {
        apiClient.fetchProductsList { result in
            switch result {
            case .success(let productsListResponse):
                DispatchQueue.main.async {
                    self.isLoading = false
                    let updatedData = productsListResponse
                    self.productsListResponse = updatedData
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
    
    
    func uploadFile(){
        isLoading = true
        guard canSave() else{
            return
        }
        
        // Create a URLSession with your view model as the delegate
                let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        let selectedUIImage1 = UIImage(contentsOfFile: selectedFile1!.path)
        let selectedUIImage2 = UIImage(contentsOfFile: selectedFile2!.path)
        let selectedUIImage3 = UIImage(contentsOfFile: selectedFile3!.path)
        apiClient.uploadFile(selectedFile1: selectedUIImage1, selectedFile2: selectedUIImage2, selectedFile3: selectedUIImage3, name: productName, description: productDescription, price: productPrice, category: productCategory){ progress in
            DispatchQueue.main.async {
                self.uploadProgress = progress
//                self.uploadProgress = uploadProgressHandler.self
            }
        } completion:{
            result in
            switch result{
            case .success(let response):
                print("SUCCESS: \(response)")
                self.showingNewItemView = false
                self.isLoading = false

                
            case .failure(let error):
                switch error {
                case .networkError(let networkError):
                    print("NETWORK ERROR: \(networkError)")
                    self.error = "Check your internet connection"
                    self.showAlert = true

                    // Handle network error
                case .noData:
                    print("NO DATA ERROR")
                    self.showAlert = true

                    // Handle no data error
                case .decodingError(let decodingError):
                    print("DECODING ERROR: \(decodingError)")
                    // Handle decoding error
                    
                }
            }
            
        }
        session.finishTasksAndInvalidate()

 
        
    }
    
    // URLSessionDelegate method to capture upload progress
      func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
          let progress = Double(totalBytesSent) / Double(totalBytesExpectedToSend)
          // You can pass the progress to your progressHandler here
          uploadProgressHandler?(progress)

      }
    
    
    
    public func canSave() -> Bool{
        
        let descriptionCharCount = productDescription.filter {$0 != " "}.count
        
        print("\(descriptionCharCount)")
        
        
        guard !productName.trimmingCharacters(in: .whitespaces).isEmpty else{
            error = "Please enter product name."
            showAlert = true
            return false
        }
        guard descriptionCharCount > 25 else{
            error = "Product description requires minimum of 25 characters."
            showAlert = true
            return false
        }
        
        guard !productPrice.trimmingCharacters(in: .whitespaces).isEmpty else{
            error = "Please product price."
            showAlert = true
            return false
        }
        guard !productCategory.trimmingCharacters(in: .whitespaces).isEmpty else{
            error = "Please select your product category."
            showAlert = true
            return false
        }
        
        
        return true
    }
}

