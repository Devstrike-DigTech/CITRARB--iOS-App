//
//  ConnectItemView.swift
//  CITRARB
//
//  Created by Richard Uzor on 04/09/2023.
//

import SwiftUI
import CachedAsyncImage


struct ConnectItemView: View {
    
    let connectItem: Connect
    
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    
    var body: some View {
        VStack{
            
            
            
            Text(connectItem.name)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading).padding(8)
            Text(connectItem.jobTitle)
                .fontWeight(.regular)
                .frame(maxWidth: .infinity, alignment: .leading).padding(8)
            
            
            
            HStack{
                Spacer()
                
                Spacer()
                connectActionImages(title: "Message", systemImageName: "message.fill"){
                    messageConnect(phoneNumber: connectItem.phone)
                }
                Spacer()
                connectActionImages(title: "Call", systemImageName: "phone.fill"){
                    makeCall(phoneNumber: connectItem.phone)
                }
                Spacer()
                connectActionImages(title: "Share", systemImageName: "square.and.arrow.up.fill"){
                    shareConnect(phoneNumber: connectItem.phone)
                }
                Spacer()
            }
            
            
        }
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
    
    
    func connectActionImages(title: String, systemImageName: String, action: @escaping() -> Void) -> some View{
        VStack{
            Image(systemName: systemImageName)
            Text(title).fontWeight(.semibold)
            
        }.padding()
            .onTapGesture {
                action()
                //open share option
            }.foregroundColor(CONNECT_COLOR)
        
    }
    
    
    func makeCall(phoneNumber: String){
        showAlert = true
        alertMessage = "Call Clicked!"
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

struct ConnectItemView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectItemView(connectItem: Connect(_id: "123", name: "Username", jobTitle: "Thiefman", phone: "0123456789", category: "Crime", description: "long long text description of which I could rather just put a placeholder of the quick brown fox jumps over the lazy dog", userId: "123"))
    }
}
