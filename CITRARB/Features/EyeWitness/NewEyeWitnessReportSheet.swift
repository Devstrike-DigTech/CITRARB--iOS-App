//
//  NewEyeWitnessReportSheet.swift
//  CITRARB
//
//  Created by Richard Uzor on 16/09/2023.
//

import SwiftUI
import UniformTypeIdentifiers


struct NewEyeWitnessReportSheet: View {
    @StateObject var viewModel = EyeWitnessReportViewModel()
    
    @Binding var newItemPresented: Bool
    @State var isShowing = false
    
    @State var image1 = "Pick Report Cover Image"
    @State var file1 = "Pick Report Video File"
   
    @State private var isPickingImage1 = false
    @State private var isPickingVideo1 = false
    

    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    
                    Text("Add New Report")
                        .font(.title)
                        .fontWeight(.heavy)
                        .padding()
                    //                if viewModel.isLoading == false{
                    Form{
                        Section(header: Text("Enter Report Title")){
                            VStack{
                                TextField("Report Title", text: $viewModel.eyeWitnessReportTitle)
                            }
                        }
                        
                        
                        Section(header: Text("Enter Report Location")){
                            VStack{
                                TextField("Report Location", text: $viewModel.eyeWitnessReportLocation)
                            }
                            
                        }

                        
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
                                                viewModel.selectedReportCoverPhoto = try result.get().first
                                                image1 = viewModel.selectedReportCoverPhoto!.lastPathComponent
                                            } catch {
                                                // Handle error
                                                print("Error picking image 1: \(error)")
                                            }
                                        }
                                        .foregroundColor(.blue)
                        
                                    Text("\(file1)")
                                        .onTapGesture {
                                            isPickingVideo1.toggle()
                                        }
                                        .fileImporter(
                                            isPresented: $isPickingVideo1,
                                            allowedContentTypes: [UTType.movie, UTType.avi],
                                            allowsMultipleSelection: false
                                        ) { result in
                                            do {
                                                viewModel.selectedReportFile = try result.get().first
                                                file1 = viewModel.selectedReportFile!.lastPathComponent
                                            } catch {
                                                // Handle error
                                                print("Error picking video 1: \(error)")
                                            }
                                        }
                                        .foregroundColor(.blue)
                        
                        Section{
                            
                    Button("Add Report"){
                        if viewModel.canSave(){
                            viewModel.uploadFile()
                            newItemPresented = false
                            
                        }else{
                            viewModel.showAlert = true
                        }
                        //close sheet
                    }
                    
                    .foregroundColor(EYE_WITNESS_COLOR)
                    .fontWeight(.bold)
                    .frame(width: 320)
                    .shadow(color: EYE_WITNESS_COLOR,radius: 8)
                    
                        }
                        .foregroundColor(EYE_WITNESS_COLOR)
                        .tint(EYE_WITNESS_COLOR)
                        .foregroundColor(EYE_WITNESS_COLOR)
                     
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
        }            .navigationTitle("Add New Report")
            }
}

struct NewEyeWitnessReportSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewEyeWitnessReportSheet(newItemPresented: Binding(get: {
            return true
        }, set: { _ in
            
        }))
    }
}
