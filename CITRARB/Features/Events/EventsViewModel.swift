//
//  EventsViewModel.swift
//  CITRARB
//
//  Created by Richard Uzor on 17/07/2023.
//

import Foundation
import UIKit

class EventsViewModel: NSObject, ObservableObject, URLSessionDelegate{
    
    
    @Published var eventsListResponse: GetAllEvents?
    @Published var isLoading: Bool = true
    @Published var selectedEventItem: IdentifiableEventListItem? // Added
    @Published var isShowingEventItem: Bool = false
    @Published var showingNewItemView = false
    @Published var error: String?
    @Published var showAlert = false
    @Published var uploadProgress: Double = 0.0
    @Published var eventName = ""
    @Published var eventLocation = ""
    @Published var eventTime = Date()
    @Published var eventDescription = ""
    @Published var selectedFile1: URL? = URL(string: "")
    

    @Published var uploadProgressHandler: ((Double) -> Void)?

    let apiClient = EventsAPIClient()
    var userId = ""
    @Published var requestType: String = ""

   
    
    
    func fetchEventsList() {
        if requestType == "mine"{
            userId = userID
        }
        apiClient.fetchEventsList(userId: userId) { result in
            switch result {
            case .success(let eventsListResponse):
                DispatchQueue.main.async {
                    self.isLoading = false
                    let updatedData = eventsListResponse
                    self.eventsListResponse = updatedData
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
        let eventTimeInMillis = "\(Int(eventTime.timeIntervalSince1970 * 1000))"

        apiClient.uploadFile(selectedFile1: selectedUIImage1, name: eventName, description: eventDescription, location: eventLocation, time: eventTimeInMillis){ progress in
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
//
//    // URLSessionDelegate method to capture upload progress
//      func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
//          let progress = Double(totalBytesSent) / Double(totalBytesExpectedToSend)
//          // You can pass the progress to your progressHandler here
//          uploadProgressHandler?(progress)
//
//      }
//
//

    public func canSave() -> Bool{

        
        // Define a reference date (e.g., January 1, 2000, 00:00:00 UTC)
        let referenceDate = Date(timeIntervalSinceReferenceDate: 0)

        let descriptionCharCount = eventDescription.filter {$0 != " "}.count

        print("\(descriptionCharCount)")


        guard !eventName.trimmingCharacters(in: .whitespaces).isEmpty else{
            error = "Please enter event name."
            showAlert = true
            return false
        }
        guard descriptionCharCount > 25 else{
            error = "Event description requires minimum of 25 characters."
            showAlert = true
            return false
        }

        guard !eventLocation.trimmingCharacters(in: .whitespaces).isEmpty else{
            error = "Please enter event location."
            showAlert = true
            return false
        }
      
        // Check if myDate is uninitialized or set to the reference date
        guard eventTime != referenceDate else{
            error = "Please select event time."
            showAlert = true
            return false
            //print("myDate is uninitialized or set to the reference date.")
        }

        return true
    }
}

