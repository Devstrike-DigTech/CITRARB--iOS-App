//
//  TVListView.swift
//  CITRARB
//
//  Created by Richard Uzor on 18/07/2023.
//

import SwiftUI

struct TVListView: View {
    @StateObject private var viewModel = TVListViewModel()
    @State private var searchText = ""

    
    var body: some View {
        NavigationView{
            ZStack{
                //            Image("bgDay")
                //              .aspectRatio(contentMode: .fill)
                //              .opacity(0.5)
                if viewModel.isLoading == false{
                    VStack{
                        SearchBarView(text: $searchText)
                        if let tvList = viewModel.tvListResponse{
                            let filteredTvList = tvList.data.filter { tvItem in
                                return searchText.isEmpty || tvItem.title.localizedCaseInsensitiveContains(searchText) || tvItem.description.localizedCaseInsensitiveContains(searchText)
                            }
                            List{
                                // Display the fetched data
                                ForEach(filteredTvList, id: \.Link){ tvItem in
                                    
                                    TVListItemView( videoThumbnail: tvItem.thumbnails.default!.url, videoTitle: tvItem.title)
                                            .onTapGesture {
                                            viewModel.isShowingTVItem = true
                                                viewModel.selectedTVItem = IdentifiableTVListItem(id: tvItem.Link, tvItem: tvItem)
                                        }
                                }
                               
                            }
                            .sheet(item: $viewModel.selectedTVItem){ identifiableTVListItem in
                                TVSheetView(tvItem: identifiableTVListItem.tvItem)
                            }
                            .refreshable {
                                viewModel.fetchTVListData()
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
            viewModel.fetchTVListData()
        }
        .navigationBarTitle("TV Videos")
    }
}

struct TVListView_Previews: PreviewProvider {
    static var previews: some View {
        TVListView()
    }
}
