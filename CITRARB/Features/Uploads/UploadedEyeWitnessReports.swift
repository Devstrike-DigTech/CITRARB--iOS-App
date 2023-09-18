//
//  UploadedEyeWitnessReports.swift
//  CITRARB
//
//  Created by Richard Uzor on 17/09/2023.
//

import SwiftUI

struct UploadedEyeWitnessReports: View {
    @StateObject private var viewModel = EyeWitnessReportViewModel()
    @State private var searchText = ""
    
    @State private var newConnectsList: [EyeWitnessReport] = []
    var body: some View {
        NavigationView{
            ZStack{
                //            Image("bgDay")
                //              .aspectRatio(contentMode: .fill)
                //              .opacity(0.5)
                if viewModel.isLoading == false{
                    VStack{
                        SearchBarView(text: $searchText)
                        
                        if let eyeWitnessList = viewModel.reportsListResponse{
                            
                            let filteredReports = eyeWitnessList.data.filter { eyeWitnessItem in
                                return searchText.isEmpty || eyeWitnessItem.title.localizedCaseInsensitiveContains(searchText) || eyeWitnessItem.userId.username.localizedCaseInsensitiveContains(searchText) ||
                                eyeWitnessItem.location.localizedCaseInsensitiveContains(searchText)
                            }
                            
                            List{
                                // Display the fetched data
                                ForEach(filteredReports, id: \._id){ eyeWitnessItem in
                                    
                                    displayEyeWitnessItems(eyeWitnessItem: eyeWitnessItem)
                                    
                                    
                                }
                            }
                            .sheet(isPresented: $viewModel.isShowingEyeWitnessItem, onDismiss: {
                                refreshList()}){
                                UploadedReportsSheetView(eyeWitnessItem: viewModel.selectedEyeWitnessItem!, reportItemPresented: $viewModel.isShowingEyeWitnessItem)
                            }
                            .refreshable {
                                viewModel.requestType = "mine"
                                viewModel.fetchReportsList()
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
            
            viewModel.fetchReportsList()
        }
        .sheet(isPresented: $viewModel.showingNewItemView){
            NewEyeWitnessReportSheet(newItemPresented: self.$viewModel.showingNewItemView)
        }
    }
    
    
    func displayEyeWitnessItems(eyeWitnessItem: EyeWitnessReport) -> some View{
        
        EyeWitnessItemView(eyeWitnessItem: eyeWitnessItem)
            .onTapGesture {
                viewModel.isShowingEyeWitnessItem.toggle()
                viewModel.selectedEyeWitnessItem = IdentifiableReportListItem(id: eyeWitnessItem._id, eyeWitnessItem: eyeWitnessItem)
            }
    }
    func refreshList() -> Void{
        viewModel.requestType = "mine"
        
        viewModel.fetchReportsList()
    }
}

struct UploadedEyeWitnessReports_Previews: PreviewProvider {
    static var previews: some View {
        UploadedEyeWitnessReports()
    }
}
