//
//  ProfileBioDataView.swift
//  CITRARB
//
//  Created by Richard Uzor on 19/09/2023.
//

import SwiftUI

struct ProfileBioDataView: View {
    
    let userProfile: ProfileUser
    var body: some View {
        VStack{
            
   
//          
            
            Text("Gender")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 4, leading: 4, bottom: 2, trailing: 0))
            
            Text(userProfile.gender ?? "N/A")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 2, leading: 8, bottom: 2, trailing: 0))
            
            Text("Email Address")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 4, leading: 4, bottom: 2, trailing: 0))
            
            Text(userProfile.email)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 2, leading: 8, bottom: 2, trailing: 0))
                .foregroundColor(.black)
            
            Text("Phone Number")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 4, leading: 4, bottom: 2, trailing: 0))
            
            HStack{
                Text(userProfile.phone ?? "08132665650")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Image(systemName: "square.and.pencil")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 8))
                    .foregroundColor(.blue)
                    .onTapGesture {
                        //showToast = true
                    }
                
            }
            .padding(EdgeInsets(top: 2, leading: 8, bottom: 2, trailing: 0))
            
        }
    }
}

struct ProfileBioDataView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileBioDataView(userProfile: ProfileUser(_id: "123", username:  "User name", email: "user@gmail.com", role: "user", photo: "onrender.citrarb.com/default.jpg", gender: "Male", phone: "+234 813 266 5650", createdAt: "January, 2003", updatedAt: "January, 2023", __v: 1))
    }
}
