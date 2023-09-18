//
//  UploadedMusicView.swift
//  CITRARB
//
//  Created by Richard Uzor on 17/09/2023.
//

import SwiftUI

struct UploadedMusicView: View {
    @StateObject private var viewModel = MusicViewModel()
    @State private var searchText = ""
    //@State private var medicalConnects: [Connect] = []
    
    var body: some View {
        NavigationView{
            ZStack{
                //            Image("bgDay")
                //              .aspectRatio(contentMode: .fill)
                //              .opacity(0.5)
                if viewModel.isLoading == false{
                    VStack{
                        SearchBarView(text: $searchText)
                        
                        if let musicList = viewModel.musicListResponse{
                
//                            let tagFilteredList = musicList.data.filter{ productItem in
//                                return productItem.category.contains(tag)
//                            }
                            
                            let filteredMusic = musicList.data.filter { musicItem in
                                return searchText.isEmpty || musicItem.title.localizedCaseInsensitiveContains(searchText) || musicItem.userId.username.localizedCaseInsensitiveContains(searchText) ||
                                musicItem.description.localizedCaseInsensitiveContains(searchText)
                            }
                            
                            List{
                                // Display the fetched data
                                ForEach(filteredMusic, id: \._id){ musicItem in
                                    
                                    displayMusicItems(musicItem: musicItem)
                                    
                                    
                                }
                            }
                            .sheet(isPresented: $viewModel.isShowingMusicItem){
                                UploadedMusicSheetView(musicItem: viewModel.selectedMusicItem!, musicItemPresented: $viewModel.isShowingMusicItem)
                            }
                            .refreshable {
                                viewModel.requestType = "mine"
                                viewModel.fetchMusicList()
                            }
                        }
                    }
                }
                else {
                    // Show a loading view or error message while data is being fetched
                    VStack{
                        LottieView(filename: "loading")
                            .frame(width: 120,  height: 120)
                    }
                    
                }
            }
        }
        .onAppear{
            viewModel.requestType = "mine"
            viewModel.fetchMusicList()
        }
    }
    
    
    func displayMusicItems(musicItem: Music) -> some View{
        
        MusicItemView(musicItem: musicItem)
            .onTapGesture {
                viewModel.isShowingMusicItem = true
                viewModel.selectedMusicItem = IdentifiableMusicListItem(id: musicItem._id, musicItem: musicItem)
            }
    }
}

struct UploadedMusicView_Previews: PreviewProvider {
    static var previews: some View {
        UploadedMusicView()
    }
}
