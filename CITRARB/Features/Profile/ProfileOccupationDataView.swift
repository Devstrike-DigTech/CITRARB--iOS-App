//
//  ProfileOccupationDataView.swift
//  CITRARB
//
//  Created by Richard Uzor on 19/09/2023.
//

import SwiftUI

struct ProfileOccupationDataView: View {
    
    let userOccupation: ProfileOccupation
    @StateObject private var viewModel = ConnectsViewModel()

    var body: some View {
        VStack{
            
            HStack{
                Text("edit")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 8))
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        //showToast = true
                        viewModel.showingNewItemView.toggle()

                    }
            }
            
            
            Text("Job Title")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 4, leading: 4, bottom: 2, trailing: 0))
            
            Text(userOccupation.jobTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 2, leading: 8, bottom: 2, trailing: 0))
            
            Text("Job Name")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 4, leading: 4, bottom: 2, trailing: 0))
            
            Text(userOccupation.name)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 2, leading: 8, bottom: 2, trailing: 0))
                .foregroundColor(.black)
            
            Text("Phone Number")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 4, leading: 4, bottom: 2, trailing: 0))
            
            
            Text(userOccupation.phone)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 2, leading: 8, bottom: 2, trailing: 0))
            
            Text("Job Description")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 4, leading: 4, bottom: 2, trailing: 0))
            
            
            Text(userOccupation.description)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 2, leading: 8, bottom: 2, trailing: 0))
            
            
        }.sheet(isPresented: $viewModel.showingNewItemView){
            EditProfileOccupationSheet(newItemPresented: self.$viewModel.showingNewItemView, occupationToEdit: userOccupation)
        }
        
    }
}

struct ProfileOccupationDataView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileOccupationDataView(userOccupation: ProfileOccupation(_id: "123", name: "Luomy EQua", jobTitle: "Carpenter", phone: "08134527878", category: "Other", description: "The noble occupation of beautification", userId: "1122", __v: 0))
    }
}
