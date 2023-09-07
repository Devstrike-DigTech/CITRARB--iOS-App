//
//  AllConnectsView.swift
//  CITRARB
//
//  Created by Richard Uzor on 04/09/2023.
//

import SwiftUI

struct AllConnectsView: View {
    
    @StateObject private var viewModel = ConnectsViewModel()
    @State private var searchText = ""
    //@State private var medicalConnects: [Connect] = []
    
    let tag: String
    @State private var newConnectsList: [Connect] = []
    //let connectList: [Connect]
    
    //medical
    //service
    //tech
    //all
    
    
    var body: some View {
        NavigationView{
            ZStack{
                //            Image("bgDay")
                //              .aspectRatio(contentMode: .fill)
                //              .opacity(0.5)
                if viewModel.isLoading == false{
                    VStack{
                        SearchBarView(text: $searchText)
                        
                        if let connectsList = viewModel.connectsListResponse{
                
                            let tagFilteredList = connectsList.data.filter{ connectItem in
                                return connectItem.category.contains(tag)
                            }
                            
                            let filteredConnects = tagFilteredList.filter { connectItem in
                                return searchText.isEmpty || connectItem.name.localizedCaseInsensitiveContains(searchText) || connectItem.jobTitle.localizedCaseInsensitiveContains(searchText) ||
                                connectItem.category.localizedCaseInsensitiveContains(searchText) ||
                                connectItem.description.localizedCaseInsensitiveContains(searchText)
                            }
                            
                            List{
                                // Display the fetched data
                                ForEach(filteredConnects, id: \._id){ connectItem in
                                    
                                    displayConnectsItems(connectItem: connectItem)
                                    
                                    
                                }
                            }
                            .sheet(item: $viewModel.selectedConnectItem){ identifiableConnectListItem in
                                ConnectSheetView(connectItem: identifiableConnectListItem.connectItem)
                            }
                            .refreshable {
                                viewModel.fetchConnectsList()
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
            viewModel.fetchConnectsList()
        }
    }
    
    func displayConnectsItems(connectItem: Connect) -> some View{
        
        ConnectItemView(connectItem: connectItem)
            .onTapGesture {
                viewModel.isShowingConnectItem = true
                viewModel.selectedConnectItem = IdentifiableConnectListItem(id: connectItem._id, connectItem: connectItem)
            }
    }
    
}

struct AllConnectsView_Previews: PreviewProvider {
    static var previews: some View {
        AllConnectsView(tag: "all")
    }
}
