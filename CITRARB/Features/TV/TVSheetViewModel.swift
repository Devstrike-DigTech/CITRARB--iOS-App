//
//  TVSheetViewModel.swift
//  CITRARB
//
//  Created by Richard Uzor on 02/08/2023.
//

import Foundation

class TVSheetViewModel: ObservableObject{
    @Published var videoID = ""
       @Published var videoTitle = ""
       @Published var videoDescription = ""
       
    init(videoID: String, videoTitle: String, videoDescription: String){
           self.videoID = videoID
           self.videoTitle = videoTitle
           self.videoDescription = videoDescription
       }
       
}
