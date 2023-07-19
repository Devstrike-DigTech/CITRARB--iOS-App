//
//  TVListView.swift
//  CITRARB
//
//  Created by Richard Uzor on 18/07/2023.
//

import SwiftUI

struct TVListView: View {
    @StateObject private var viewModel = TVListViewModel()
    
    var body: some View {
        NavigationView{
            ZStack{
                //            Image("bgDay")
                //              .aspectRatio(contentMode: .fill)
                //              .opacity(0.5)
                if viewModel.isLoading == false{
                    if let tvList = viewModel.tvListResponse{
                        List{
                            // Display the fetched data
                            ForEach(tvList.data, id: \.Link){ tvItem in
                                
                                TVListItemView( videoThumbnail: tvItem.thumbnails.default!.url, videoTitle: tvItem.title)
                            }
                            
                        }.refreshable {
                            viewModel.fetchTVListData()
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
