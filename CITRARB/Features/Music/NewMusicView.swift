//
//  NewMuusicView.swift
//  CITRARB
//
//  Created by Richard Uzor on 15/09/2023.
//

import SwiftUI

struct NewMusicView: View {
    @StateObject var viewModel = MusicViewModel()
    
    @Binding var newItemPresented: Bool
    @State var isShowing = false
    
    @State var image1 = "Pick Music Cover Image"
    @State var file1 = "Pick Music File"
   
    @State private var isPickingImage1 = false
    @State private var isPickingMusic1 = false
    
    let musicGenres = ["Afrobeat", "Gospel", "Rap", "Others"]

      
    
    
    var charCount: Int {
        viewModel.musicDescription.filter { $0 != " " }.count
    }
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    
                    Text("Add New Music")
                        .font(.title)
                        .fontWeight(.heavy)
                        .padding()
                    //                if viewModel.isLoading == false{
                    Form{
                        Section(header: Text("Enter Music Title")){
                            VStack{
                                TextField("Music Title", text: $viewModel.musictitle)
                            }
                        }
                        Section(header: Text("Select Music Genre")){
                            VStack{
                                Picker("Music Genre", selection: $viewModel.musicGenre){
                                    ForEach(musicGenres, id: \.self){ option in
                                        Text((option)).tag(option)
                                    }
                                }.pickerStyle(SegmentedPickerStyle())
                            }
                        }
                        
                        Section(header: Text("Enter Music Description (min 25 chars):"), content: {
                            VStack {
                                ScrollView{
                                    TextEditor(text: $viewModel.musicDescription).lineLimit(3)
                                        .frame(width: 300, height: 100)
                                }
                                //                            let charCount = $viewModel.description.filter {$0 != " "}.count
                                //
                                if charCount < 25 {
                                    Text(String(charCount)).foregroundColor(.red)
                                } else {
                                    Text(viewModel.musicDescription.isEmpty ? "0" : String(charCount))                            }
                            }
                        })
                        
                        Section(header: Text("Enter Music Stream Link")){
                            VStack{
                                TextField("Stream Link", text: $viewModel.musicStreamLink)
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
                                                viewModel.selectedCoverPhotoFile1 = try result.get().first
                                                image1 = viewModel.selectedCoverPhotoFile1!.lastPathComponent
                                            } catch {
                                                // Handle error
                                                print("Error picking image 1: \(error)")
                                            }
                                        }
                                        .foregroundColor(.blue)
                        
                                    Text("\(file1)")
                                        .onTapGesture {
                                            isPickingMusic1.toggle()
                                        }
                                        .fileImporter(
                                            isPresented: $isPickingMusic1,
                                            allowedContentTypes: [.audio],
                                            allowsMultipleSelection: false
                                        ) { result in
                                            do {
                                                viewModel.selectedMusicFile1 = try result.get().first
                                                file1 = viewModel.selectedMusicFile1!.lastPathComponent
                                            } catch {
                                                // Handle error
                                                print("Error picking music 1: \(error)")
                                            }
                                        }
                                        .foregroundColor(.blue)
                        
                        Section{
                            
                    Button("Add Music"){
                        if viewModel.canSave(){
                            viewModel.uploadFile()
                            newItemPresented = false
                            
                        }else{
                            viewModel.showAlert = true
                        }
                        //close sheet
                    }
                    
                    .foregroundColor(MUSIC_COLOR)
                    .fontWeight(.bold)
                    .frame(width: 320)
                    .shadow(color: MUSIC_COLOR,radius: 8)
                    
                        }
                        .foregroundColor(MUSIC_COLOR)
                        .tint(MUSIC_COLOR)
                        .foregroundColor(MUSIC_COLOR)
                     
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
        }            .navigationTitle("Add New Music")
            }
}

struct NewMuusicView_Previews: PreviewProvider {
    static var previews: some View {
        NewMusicView(newItemPresented: Binding(get: {
            return true
        }, set: { _ in
            
        }))
    }
}
