//
//  EventItemView.swift
//  CITRARB
//
//  Created by Richard Uzor on 12/09/2023.
//

import SwiftUI
import CachedAsyncImage


struct EventItemView: View {
    
    let eventItem: Event
    
    var body: some View {
        HStack{
            //use the cachedasyncimage library to load and cache the news image from the url
            CachedAsyncImage(url: URL(string: "\(BASE_NORMAL_URL) \(eventItem.image ?? "default.jpg")"),
//            CachedAsyncImage(url: URL(string: eventItem.image ?? "https://media.licdn.com/dms/image/C4E03AQHoxyHK4nbxZw/profile-displayphoto-shrink_800_800/0/1517428411478?e=2147483647&v=beta&t=THfF7Lmo6_s6lRXEMDGr_X3qTa5p4g5jO8wAhU7cnf0"),
                             transaction: Transaction(animation: .easeInOut)){ phase in
                //set an animation to display the placeholder image
                if let image = phase.image{
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .transition(.opacity)
                        .frame(width: 120, height: 240)
                        .padding(4)
                }else{
                    HStack{
                        ProgressView()
                    }
                    
                }
            }
            VStack{
                Text(eventItem.name)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading).padding(4)
                
                Text(formatDateString(eventItem.time)!)
                    .fontWeight(.regular)
                    .frame(maxWidth: .infinity, alignment: .leading).padding(4)
                
                Text(eventItem.location)
                    .fontWeight(.regular)
                    .frame(maxWidth: .infinity, alignment: .leading).padding(4)
                
                Text("\(eventItem.host.username) (Host)")
                    .fontWeight(.regular)
                    .frame(maxWidth: .infinity, alignment: .leading).padding(4)
                
                
            }
            .padding()
        }
    }
}

struct EventItemView_Previews: PreviewProvider {
    static var previews: some View {
        EventItemView(eventItem: Event(_id: "123", name: "Launching Event", coHosts: [], image: "https://fastly.picsum.photos/id/9/5000/3269.jpg?hmac=cZKbaLeduq7rNB8X-bigYO8bvPIWtT-mh8GRXtU3vPc", time: "Sun 19-Aug-2023 | 05:30PM", location: "Agangu River", host: Host(_id: "112", username: "Odozi Obodo", email: "oo@gmail.com", role: "user", photo: "https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U", createdAt: "12-03-2023", updatedAt: "12-03-2023", __v: 1, gender: "Male", phone: ""), description: "This is the description of the event", numberOfAttendee: 3, eventAttendance: [], id: "123"))
    }
}
