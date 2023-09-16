//
//  MusicSheetView.swift
//  CITRARB
//
//  Created by Richard Uzor on 13/09/2023.
//

import SwiftUI
import UIKit
import CachedAsyncImage
import AVFoundation
import AVKit


struct MusicSheetView: View {
    let musicItem: Music
    
    @StateObject private var viewModel = MusicViewModel()

    
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isPlayingMusic = false
    @State private var musicImage = "play.circle.fill"
    
    
    
    
    
    var body: some View {
        NavigationView{
            VStack{
                //put cover image here and a play button by bottom right
                CachedAsyncImage(url: URL(string: "\(BASE_NORMAL_URL)\(musicItem.image)"),
                                 transaction: Transaction(animation: .easeInOut)){ phase in
                    //set an animation to display the placeholder image
                    if let image = phase.image{
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .transition(.opacity)
                            .frame(width: 320, height: 240)
                            .padding(4)
                    }else{
                        HStack{
                            ProgressView()
                        }
                        
                    }
                }
                
                Image(systemName: isPlayingMusic ? "pause.circle.fill": "play.circle.fill")
                    .frame(maxWidth: .infinity, alignment: .leading).padding(8)
                    .font(.title)
                    .foregroundColor(MUSIC_COLOR)
                    .onTapGesture {
                        viewModel.playSound(sound: "\(BASE_NORMAL_URL)\(musicItem.file)")
                        isPlayingMusic.toggle()
                        if isPlayingMusic == true{
                            viewModel.audioPlayer?.play()
                        }else{
                            viewModel.audioPlayer?.pause()

                        }
                        
                    }
                
                HStack{
                    Text(musicItem.title).font(.title2)
                    Spacer()
                    
                    musicActionImages(systemImageName: "message.fill"){ messageConnect(phoneNumber: musicItem.userId.phone ?? "0")}
                    musicActionImages(systemImageName: "phone.fill"){
                        makeCall(phoneNumber: musicItem.userId.phone ?? "0")}
                    musicActionImages(systemImageName: "square.and.arrow.up.fill"){ shareConnect(phoneNumber: musicItem.userId.phone ?? "0")}
                    
                }
                .padding(8)
                .foregroundColor(.black)
                .shadow(color: .black,radius: 120)
                
                
                Text(musicItem.userId.username).frame(maxWidth: .infinity, alignment: .leading).padding(4)
                
                Text(musicItem.description).frame(maxWidth: .infinity, alignment: .leading).padding(4)
                
                
            }
            .padding(8)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Alert Title"),
                    message: Text(alertMessage),
                    primaryButton: .default(Text("OK")) {
                        showAlert = false // Close the alert when OK is tapped
                    },
                    secondaryButton: .cancel() {
                        showAlert = false // Close the alert when Cancel is tapped
                    }
                )
            }
        }
    }
    
    // Function to play audio
    func playAudio(musicLink: String) {
           let playerViewController = AVPlayerViewController()
           let player = AVPlayer(url: URL(string: musicLink)!)
        print(musicLink)
        UIViewControllerRepresenter(player: player)
                    .frame(width: UIScreen.main.bounds.width, height: 300)

//           playerViewController.player = player
//        // Get the current window scene
//        if let windowScene = UIApplication.shared.windows.first?.windowScene {
//            // Present the AVPlayerViewController on the current window scene
//            windowScene.windows.first?.rootViewController?.present(playerViewController, animated: true) {
//                playerViewController.player?.play()
//            }
//        }
       }
    
    func musicActionImages(systemImageName: String, action: @escaping() -> Void) -> some View{
        Image(systemName: "\(systemImageName)").padding(4).font(.title2).foregroundColor(MUSIC_COLOR)
            .padding(8)
            .foregroundColor(.black)
            .shadow(color: .black,radius: 120)
            .onTapGesture {
                action()
            }
        
    }
    
    
    
    func makeCall(phoneNumber: String){
        if let phoneURL = URL(string: "tel:\(phoneNumber)"), UIApplication.shared.canOpenURL(phoneURL) {
                      UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
                  }
        //showAlert = true
        //alertMessage = "Call Clicked!"
    }
    func shareConnect(phoneNumber: String){
        showAlert = true
        alertMessage = "Share Clicked!"
    }
    func messageConnect(phoneNumber: String){
        showAlert = true
        alertMessage = "Message Clicked!"
    }
}
struct MusicSheetView_Previews: PreviewProvider {
    static var previews: some View {
        MusicSheetView(musicItem: Music(_id: "123", file: "https://citrab.onrender.com/music--16947832598719128.mp3", title: "Music Title", userId: MusicOwner(_id: "123", username: "Davido", email: "davido@email.com", role: "user", photo: "https://citrab.onrender.com/music-cover--16866649712495016.jpeg", phone: "08132665650", gender: "Male", createdAt: "12-08-2023", updatedAt: "12-08-2023", __v: 1), description: "Music Description", isVerified: false, image: "Whi ompice dt ratiner", createdAt: "12-89-203", updatedAt: "12-89-2003", reactions: ["String"], id: "123"))
    }
}
