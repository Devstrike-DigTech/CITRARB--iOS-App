//
//  EventsSheetView.swift
//  CITRARB
//
//  Created by Richard Uzor on 12/09/2023.
//

import SwiftUI
import CachedAsyncImage


struct EventsSheetView: View {
    
    let eventItem: Event
    
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack{
            
//            CachedAsyncImage(url: URL(string: eventItem.image!),
            CachedAsyncImage(url: URL(string: "\(BASE_NORMAL_URL)\(eventItem.image ?? "default.jpg")"),
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
            HStack{
                Text(eventItem.name).font(.title2)
                Spacer()
                
                productActionImages(systemImageName: "message.fill"){ messageConnect(phoneNumber: eventItem.host.phone ?? "0")}
                productActionImages(systemImageName: "phone.fill"){ makeCall(phoneNumber: eventItem.host.phone ?? "0")}
                productActionImages(systemImageName: "square.and.arrow.up.fill"){ shareConnect(phoneNumber: eventItem.host.phone ?? "0")}
                
            }
            .padding(8)
            .foregroundColor(.black)
            .shadow(color: .black,radius: 120)
            
            
        
            Text("Hosted by: \(eventItem.host.username)").frame(maxWidth: .infinity, alignment: .leading).padding(4)
            Text(formatDateString(_: eventItem.time)!).frame(maxWidth: .infinity, alignment: .leading).padding(4)
            Text(eventItem.location).frame(maxWidth: .infinity, alignment: .leading).padding(4)
                .onTapGesture {
                    openMapsAppWithLocation(locationName: eventItem.location)
                }
            Text(eventItem.description).frame(maxWidth: .infinity, alignment: .leading).padding(4)
            Button("Going"){
                addReminder(title: eventItem.name, notes: eventItem.location, dueDate: dateFromISOString(eventItem.time))
                // send Post request
            }
            .padding()
            .frame(width: 120, height: 80)
            
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
    
    
    func productActionImages(systemImageName: String, action: @escaping() -> Void) -> some View{
        Image(systemName: "\(systemImageName)").padding(4).font(.title2).foregroundColor(EVENTS_COLOR)
            .padding(8)
            .foregroundColor(.black)
            .shadow(color: .black,radius: 120)
            .onTapGesture {
                action()
            }
        
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

struct EventsSheetView_Previews: PreviewProvider {
    static var previews: some View {
        EventsSheetView(eventItem: Event(_id: "123", name: "Launching Event", coHosts: [], image: "https://fastly.picsum.photos/id/9/5000/3269.jpg?hmac=cZKbaLeduq7rNB8X-bigYO8bvPIWtT-mh8GRXtU3vPc", time: "2023-06-12T05:14:59.000Z", location: "Agangu River", host: Host(_id: "112", username: "Odozi Obodo", email: "oo@gmail.com", role: "user", photo: "https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U", createdAt: "12-03-2023", updatedAt: "12-03-2023", __v: 1, gender: "Male", phone: ""), description: "This is the description of the event", numberOfAttendee: 3, eventAttendance: [], id: "123"))
    }
}
