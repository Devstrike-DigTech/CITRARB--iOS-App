//
//  EditProfileOccupationSheet.swift
//  CITRARB
//
//  Created by Richard Uzor on 19/09/2023.
//

import SwiftUI

struct EditProfileOccupationSheet: View {
    @StateObject var viewModel = ConnectsViewModel()
    
    @Binding var newItemPresented: Bool
    let occupationToEdit: ProfileOccupation
    
    
    
    let jobCategories = ["Medical", "Service", "Tech", "Others"]
    
    var charCount: Int {
           viewModel.description.filter { $0 != " " }.count
       }

    var body: some View {
        NavigationView{
            VStack{
                
                Text("Update Your Occupation")
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding()
//                if viewModel.isLoading == false{
                    Form{
                        Section(header: Text("Enter Updated Name")){
                            VStack{
                                TextField("Name", text: $viewModel.name)
                            }
                        }
    //                    //                - - - - - this makes it a dropdown menu - - - - - -
                        Section(header: Text("Select Job Category")){
                            VStack{
                                Picker("Job Category", selection: $viewModel.category){
                                    ForEach(jobCategories, id: \.self){ option in
                                        Text((option)).tag(option)
                                    }
                                }.pickerStyle(SegmentedPickerStyle())
                            }
                        }

                        Section(header: Text("Select Job Title")){
                            VStack{
                                TextField("Job Title", text: $viewModel.jobTitle)
                            }

                        }
                        Section(header: Text("Enter Your Phone Number")){
                            VStack{
                                TextField("Phone Number", text: $viewModel.phone).keyboardType(.numberPad)
                            }
                        }
                        Section(header: Text("Enter Your Job Description (min 25 chars):"), content: {
                            VStack {
                                ScrollView{
                                    TextEditor(text: $viewModel.description).lineLimit(3)
                                        .frame(width: 300, height: 100)
                                }
    //                            let charCount = $viewModel.description.filter {$0 != " "}.count
    //
                                if charCount < 25 {
                                    Text(String(charCount)).foregroundColor(.red)
                                } else {
                                    Text(viewModel.description.isEmpty ? "0" : String(charCount))                            }
                            }
                        })
                        
                        Button("Update Occupation"){
                            if viewModel.canSave(){
                                viewModel.updateConnect(occupationId: occupationToEdit._id)
                                newItemPresented = false

                            }else{
                                    viewModel.showAlert = true
                                }
                                //close sheet
                        }
                        
                        .foregroundColor(CONNECT_COLOR)
                        .fontWeight(.bold)
                        .frame(width: 320)
                        .shadow(color: CONNECT_COLOR,radius: 8)
                        
                    }
                
                
//                }else{
//                    LoadingDialog(isLoading: true)
//                }
                
                   
                
            }
            
        }.onAppear{
            viewModel.name = occupationToEdit.name
            viewModel.phone = occupationToEdit.phone
            viewModel.jobTitle = occupationToEdit.jobTitle
            viewModel.category = occupationToEdit.category
            viewModel.description = occupationToEdit.description
        }
        .alert(isPresented: $viewModel.showAlert){
            Alert(title: Text("Error"), message: Text(viewModel.error!))
        }            .navigationTitle("Update Your Occupation")
        
    }
}

struct EditProfileOccupationSheet_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileOccupationSheet(newItemPresented: Binding(get: {
            return true
        }, set: { _ in
            
        }), occupationToEdit: ProfileOccupation(_id: "123", name: "Luomy EQua", jobTitle: "Carpenter", phone: "08134527878", category: "Medical", description: "The noble occupation of beautification", userId: "1122", __v: 0))
    }
}
