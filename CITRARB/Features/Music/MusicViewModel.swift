//
//  MusicViewModel.swift
//  CITRARB
//
//  Created by Richard Uzor on 17/07/2023.
//

import Foundation
import UIKit
import AVFoundation




class MusicViewModel: NSObject, ObservableObject, URLSessionDelegate{
    
    
    @Published var musicListResponse: GetAllMusicResponse?
    @Published var isLoading: Bool = true
    @Published var selectedMusicItem: IdentifiableMusicListItem? // Added
    @Published var isShowingMusicItem: Bool = false
    @Published var showingNewItemView = false
    @Published var error: String?
    @Published var showAlert = false
    @Published var uploadProgress: Double = 0.0
    @Published var musictitle = ""
    @Published var musicDescription = ""
    @Published var musicGenre = ""
    @Published var musicStreamLink = ""
    @Published var selectedMusicFile1: URL? = URL(string: "")
    @Published var selectedCoverPhotoFile1: URL? = URL(string: "")
    
    var audioPlayer: AVPlayer?

    var userId = ""
    @Published var requestType: String = ""

    
    
    @Published var uploadProgressHandler: ((Double) -> Void)?
    
    let apiClient = MusicAPIClient()
    
    
    func fetchMusicList() {
        if requestType == "mine"{
            userId = userID
        }
        print("user id\(userId)")
        apiClient.fetchMusicList(userId: userId) { result in
            switch result {
            case .success(let musicListResponse):
                DispatchQueue.main.async {
                    self.isLoading = false
                    let updatedData = musicListResponse
                    self.musicListResponse = updatedData
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
        let selectedCoverUIImage1 = UIImage(contentsOfFile: selectedCoverPhotoFile1!.path)!
        fetchData(from: selectedMusicFile1!) { data in
              if let data = data {
                  // You have the data from the URL in the 'data' variable
                  print("Data received successfully: \(data.count) bytes")
                  
                  // You can assign 'data' to your variable here
                  // let myVariable = data
                  
                  self.apiClient.uploadFile(name: self.musictitle, description: self.musicDescription, link: self.musicStreamLink, genre: self.musicGenre, coverImage: selectedCoverUIImage1, audioFile: data){ progress in
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
    
    
    func deleteMusic(musicId: String) {
        
        apiClient.deleteMusic(musicId: musicId) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.isLoading = false
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
                self.isLoading = false
                // Handle error (e.g., show an alert)
                
            }
        }
        
    }
    
    //
    // URLSessionDelegate method to capture upload progress
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        let progress = Double(totalBytesSent) / Double(totalBytesExpectedToSend)
        // You can pass the progress to your progressHandler here
        uploadProgressHandler?(progress)
        
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
    
    
    func playSound(sound: String){
        if let url = URL(string: sound) {
            self.audioPlayer = AVPlayer(url: url)
        }
    }
    
    public func canSave() -> Bool{
        
        
        // Define a reference date (e.g., January 1, 2000, 00:00:00 UTC)
        let referenceDate = Date(timeIntervalSinceReferenceDate: 0)
        
        let descriptionCharCount = musicDescription.filter {$0 != " "}.count
        let musicFileExtension = selectedMusicFile1?.pathExtension.lowercased()
        
        print("\(descriptionCharCount)")
        
        
        guard !musictitle.trimmingCharacters(in: .whitespaces).isEmpty else{
            error = "Please enter music title."
            showAlert = true
            return false
        }
        
        guard !musicGenre.trimmingCharacters(in: .whitespaces).isEmpty else{
            error = "Please select music genre."
            showAlert = true
            return false
        }
        
        
        guard descriptionCharCount > 25 else{
            error = "Music description requires minimum of 25 characters." //preferrably the stream link
            showAlert = true
            return false
        }
        
        guard !musicStreamLink.trimmingCharacters(in: .whitespaces).isEmpty else{
            error = "Please enter music stream link."
            showAlert = true
            return false
        }
        
        guard selectedCoverPhotoFile1 != nil else{
            error = "Please select music cover image."
            showAlert = true
            return false
        }
        guard !selectedCoverPhotoFile1!.absoluteString.isEmpty else{
            error = "Please select music cover image."
            showAlert = true
            return false
        }
        
        guard selectedMusicFile1 != nil else{
            error = "Please select music file."
            showAlert = true
            return false
        }
        
        guard !selectedMusicFile1!.absoluteString.isEmpty else{
            error = "Please select music file."
            showAlert = true
            return false
        }
        
        guard musicFileExtension == "mp3" else{
            error = "Please select an mp3 file."
            showAlert = true
            return false
        }
      
        
        return true
    }
}


