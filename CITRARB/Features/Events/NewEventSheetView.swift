//
//  NewEventSheetView.swift
//  CITRARB
//
//  Created by Richard Uzor on 12/09/2023.
//

import SwiftUI

struct NewEventSheetView: View {
    
    @StateObject var viewModel = EventsViewModel()
    
    @Binding var newItemPresented: Bool
    @State var isShowing = false
    
    @State var image1 = "Pick Event Cover Image"
   
    @State private var isPickingImage1 = false
      
    
    
    var charCount: Int {
        viewModel.eventDescription.filter { $0 != " " }.count
    }
    // Calculate the minimum selectable date (e.g., today)
      private var minimumDate: Date {
          let calendar = Calendar.current
          let today = calendar.startOfDay(for: Date())
          return today
      }
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    
                    Text("Add New Event")
                        .font(.title)
                        .fontWeight(.heavy)
                        .padding()
                    //                if viewModel.isLoading == false{
                    Form{
                        Section(header: Text("Enter Event Name")){
                            VStack{
                                TextField("Event Name", text: $viewModel.eventName)
                            }
                        }
                        Section(header: Text("Enter Event Time")){
                            DatePicker("Time", selection: $viewModel.eventTime, in: minimumDate...)
                                                .datePickerStyle(DefaultDatePickerStyle())
                        }
                        Section(header: Text("Enter Event Location")){
                            VStack{
                                TextField("Event Location", text: $viewModel.eventLocation)
                            }
                            
                        }
                        Section(header: Text("Enter Event Description (min 25 chars):"), content: {
                            VStack {
                                ScrollView{
                                    TextEditor(text: $viewModel.eventDescription).lineLimit(3)
                                        .frame(width: 300, height: 100)
                                }
                                //                            let charCount = $viewModel.description.filter {$0 != " "}.count
                                //
                                if charCount < 25 {
                                    Text(String(charCount)).foregroundColor(.red)
                                } else {
                                    Text(viewModel.eventDescription.isEmpty ? "0" : String(charCount))                            }
                            }
                        })

                        
                                    Text("\(image1)")
                                        .onTapGesture {
                                            isPickingImage1.toggle()
                                        }
                                        .fileImporter(
                                            isPresented: $isPickingImage1,
                                            allowedContentTypes: [.image],
                                            allowsMultipleSelection: false
                                        ) { result in
                                            do {
                                                viewModel.selectedFile1 = try result.get().first
                                                image1 = viewModel.selectedFile1!.lastPathComponent
                                            } catch {
                                                // Handle error
                                                print("Error picking image 1: \(error)")
                                            }
                                        }
                                        .foregroundColor(.blue)
                        
                        Section{
                            
                    Button("Add Event"){
                        if viewModel.canSave(){
                            viewModel.uploadFile()
                            newItemPresented = false
                            
                        }else{
                            viewModel.showAlert = true
                        }
                        //close sheet
                    }
                    
                    .foregroundColor(EVENTS_COLOR)
                    .fontWeight(.bold)
                    .frame(width: 320)
                    .shadow(color: EVENTS_COLOR,radius: 8)
                    
                        }
                        .foregroundColor(EVENTS_COLOR)
                        .tint(EVENTS_COLOR)
                        .foregroundColor(EVENTS_COLOR)
                     
                    }
                }
            }
                if viewModel.isLoading{
                    // Show the progress (you can use a Text view or a ProgressBar)
                            Text("Upload Progress: \(Int(viewModel.uploadProgress * 100))%")
                }
        }
        .alert(isPresented: $viewModel.showAlert){
            Alert(title: Text("Error"), message: Text(viewModel.error!))
        }            .navigationTitle("Add New Event")
            }
}

struct NewEventSheetView_Previews: PreviewProvider {
    static var previews: some View {
        NewEventSheetView(newItemPresented: Binding(get: {
            return true
        }, set: { _ in
            
        }) )
    }
}
