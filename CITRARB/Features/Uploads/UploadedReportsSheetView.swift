//
//  UploadedReportsSheetView.swift
//  CITRARB
//
//  Created by Richard Uzor on 17/09/2023.
//

import SwiftUI

struct UploadedReportsSheetView: View {
    let eyeWitnessItem: IdentifiableReportListItem
    @Binding var reportItemPresented: Bool

    
    @StateObject private var viewModel = EyeWitnessReportViewModel()
    
    
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isPlayingVideo = false
    @State private var videoImage = "play.circle.fill"
    
    
    
    
    
    var body: some View {
        NavigationView{
            VStack{
                VideoPlayerView(reportLink: eyeWitnessItem.eyeWitnessItem.video)
                    .frame(height: 300)
                HStack{
                    Text(eyeWitnessItem.eyeWitnessItem.title).font(.title2)
                    Spacer()
                    
                    musicActionImages(systemImageName: "square.and.arrow.up.fill"){ shareConnect(phoneNumber: eyeWitnessItem.eyeWitnessItem.userId.phone ?? "0")}
                    
                }
                .padding(8)
                .foregroundColor(.black)
                .shadow(color: .black,radius: 120)
                
                
                Text(eyeWitnessItem.eyeWitnessItem.location).frame(maxWidth: .infinity, alignment: .leading).padding(4)
                
                Text("Delete")
                    .foregroundColor(.red).fontWeight(.bold)
                    .padding()
                    .onTapGesture {
                        showAlert = true
                        alertMessage = "Sure to delete this eyewitness report?"
                        

                    }
                
            }
            .padding(8)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Delete Report").fontWeight(.bold),
                    message: Text(alertMessage),
                    primaryButton: .default(Text("Yes").foregroundColor(.red)) {
                        viewModel.deleteReport(reportId: eyeWitnessItem.eyeWitnessItem.id)
                        reportItemPresented = false
                        showAlert = false // Close the alert when OK is tapped
                    },
                    secondaryButton: .cancel() {
                        showAlert = false // Close the alert when Cancel is tapped
                    }
                )
            }
        }
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

//struct UploadedReportsSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        UploadedReportsSheetView()
//    }
//}
