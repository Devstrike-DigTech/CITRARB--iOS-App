//
//  NewConnectView.swift
//  CITRARB
//
//  Created by Richard Uzor on 04/09/2023.
//

import SwiftUI

struct NewConnectView: View {
    
    @StateObject var viewModel = ConnectsViewModel()
    
    @Binding var newItemPresented: Bool
    
    
    
    let jobCategories = ["Medical", "Service", "Tech", "Others"]
    
    //name
    //category
    //title
    //phone
    //description
    var charCount: Int {
           viewModel.description.filter { $0 != " " }.count
       }

    var body: some View {
        NavigationView{
            VStack{
                
                Text("Add Your Occupation")
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding()
//                if viewModel.isLoading == false{
                    Form{
                        Section(header: Text("Enter Your Name")){
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
                        
                        Button("Add Occupation"){
                            if viewModel.canSave(){
                                viewModel.createNewConnect()
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
            
        } .alert(isPresented: $viewModel.showAlert){
            Alert(title: Text("Error"), message: Text(viewModel.error!))
        }            .navigationTitle("Add Your Occupation")
        
    }
    
}



struct NewConnectView_Previews: PreviewProvider {
    static var previews: some View {
        NewConnectView(newItemPresented: Binding(get: {
            return true
        }, set: { _ in
            
        }))
    }
}
