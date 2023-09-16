//
//  ConnectSheetView.swift
//  CITRARB
//
//  Created by Richard Uzor on 04/09/2023.
//

import SwiftUI
import CachedAsyncImage


struct ConnectSheetView: View {
    let connectItem: Connect
    
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    
    var body: some View {
        
        VStack{
            HStack{
                Text(connectItem.name).font(.title2)
                Spacer()
                
                connectActionImages(systemImageName: "message.fill"){ messageConnect(phoneNumber: connectItem.phone)}
                 connectActionImages(systemImageName: "phone.fill"){ makeCall(phoneNumber: connectItem.phone)}
                 connectActionImages(systemImageName: "square.and.arrow.up.fill"){ shareConnect(phoneNumber: connectItem.phone)}
                
            }
            .padding(8)
            .foregroundColor(.black)
            .shadow(color: .black,radius: 120)
            
            
            Text(connectItem.jobTitle).frame(maxWidth: .infinity, alignment: .leading).padding(4)
            Text(connectItem.category).frame(maxWidth: .infinity, alignment: .leading).padding(4)
            Text(connectItem.description).frame(maxWidth: .infinity, alignment: .leading).padding(4)
            
            
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
    
    
    func connectActionImages(systemImageName: String, action: @escaping() -> Void) -> some View{
        Image(systemName: "\(systemImageName)").padding(4).font(.title2).foregroundColor(CONNECT_COLOR)
            .padding(8)
            .foregroundColor(.black)
            .shadow(color: .black,radius: 120)
            .onTapGesture {
                action()
            }
        
    }
    
    
    
    func makeCall(phoneNumber: String){
        if let phoneURL = URL(string: "tel://\(phoneNumber)") {
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


struct ConnectSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectSheetView(connectItem: Connect(_id: "123", name: "Username", jobTitle: "Thiefman", phone: "0123456789", category: "Crime", description: "long long text description of which I could rather just put a placeholder of the quick brown fox jumps over the lazy dog", userId: "123"))
    }
}
