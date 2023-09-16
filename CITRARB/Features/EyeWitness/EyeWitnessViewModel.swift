//
//  EyeWitnessViewModel.swift
//  CITRARB
//
//  Created by Richard Uzor on 17/07/2023.
//

import Foundation
import UIKit



class EyeWitnessReportViewModel: NSObject, ObservableObject, URLSessionDelegate{
    
    
    @Published var reportsListResponse: GetAllEyeWitnessResponse?
    @Published var isLoading: Bool = true
    @Published var selectedEyeWitnessItem: IdentifiableReportListItem? // Added
    @Published var isShowingEyeWitnessItem: Bool = false
    @Published var showingNewItemView = false
    @Published var error: String?
    @Published var showAlert = false
    @Published var uploadProgress: Double = 0.0
    @Published var eyeWitnessReportTitle = ""
    @Published var eyeWitnessReportLocation = ""
    @Published var selectedReportCoverPhoto: URL? = URL(string: "")
    @Published var selectedReportFile: URL? = URL(string: "")
    
    @Published var uploadProgressHandler: ((Double) -> Void)?


    
    let apiClient = EyeWitnessAPIClient()
    
    
    func fetchReportsList() {
        apiClient.fetchReportsList { result in
            switch result {
            case .success(let reportsListResponse):
                DispatchQueue.main.async {
                    self.isLoading = false
                    let updatedData = reportsListResponse
                    self.reportsListResponse = updatedData
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
        let selectedCoverUIImage1 = UIImage(contentsOfFile: selectedReportCoverPhoto!.path)!
        fetchData(from: selectedReportFile!) { data in
              if let data = data {
                  // You have the data from the URL in the 'data' variable
                  print("Data received successfully: \(data.count) bytes")
                  
                  // You can assign 'data' to your variable here
                  // let myVariable = data
                  
                  self.apiClient.uploadFile(selectedFile1: selectedCoverUIImage1, name: self.eyeWitnessReportTitle, location: self.eyeWitnessReportLocation, videoFile: data){ progress in
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
                  
                  

              } else {
                  print("Failed to fetch data from URL.")
              }
          }
        
        
    }
    
    func fetchData(from url: URL, completion: @escaping (Data?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                completion(data)
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    

    // URLSessionDelegate method to capture upload progress
      func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
          let progress = Double(totalBytesSent) / Double(totalBytesExpectedToSend)
          // You can pass the progress to your progressHandler here
          uploadProgressHandler?(progress)

      }
    


    public func canSave() -> Bool{

//        let descriptionCharCount = productDescription.filter {$0 != " "}.count
//
//        print("\(descriptionCharCount)")
        
        let videoFileExtension = selectedReportFile?.pathExtension.lowercased()



        guard !eyeWitnessReportTitle.trimmingCharacters(in: .whitespaces).isEmpty else{
            error = "Please enter report title."
            showAlert = true
            return false
        }
//        guard descriptionCharCount > 25 else{
//            error = "Product description requires minimum of 25 characters."
//            showAlert = true
//            return false
//        }

        guard !eyeWitnessReportLocation.trimmingCharacters(in: .whitespaces).isEmpty else{
            error = "Please report location."
            showAlert = true
            return false
        }
        
        guard selectedReportCoverPhoto != nil else{
            error = "Please select report cover image."
            showAlert = true
            return false
        }
        guard !selectedReportCoverPhoto!.absoluteString.isEmpty else{
            error = "Please select report cover image."
            showAlert = true
            return false
        }
        
        guard selectedReportFile != nil else{
            error = "Please select report video file."
            showAlert = true
            return false
        }
        
        guard !selectedReportFile!.absoluteString.isEmpty else{
            error = "Please select report video file."
            showAlert = true
            return false
        }
        
        guard videoFileExtension == "mp4" else{
            error = "Please select an mp3 file."
            showAlert = true
            return false
        }
      

        return true
    }
}

