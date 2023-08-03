//
//  TVViewModel.swift
//  CITRARB
//
//  Created by Richard Uzor on 17/07/2023.
//

import Foundation
import Combine

class TVListViewModel: ObservableObject {
    @Published var tvListResponse: TVListResponse?
    @Published var isLoading: Bool = true
    @Published var isShowingTVItem: Bool = false
    @Published var selectedTVItem: IdentifiableTVListItem? // Added

    private var cancellables = Set<AnyCancellable>()
    
    private let apiClient = APIClient()
    
    func fetchTVListData() {
        apiClient.fetchTVList { result in
            switch result {
            case .success(let tvListResponse):
                DispatchQueue.main.async {
                    self.isLoading = false
                    let updatedData = tvListResponse.data.map { item -> TVListItem in
                                        var updatedItem = item
                        if updatedItem.thumbnails.default == nil {
                            updatedItem.thumbnails.default = Metric(height: 120, width: 120)
                                        }
                                        return updatedItem
                                    }
                    self.tvListResponse = TVListResponse(data: updatedData, fromCache: tvListResponse.fromCache, total: tvListResponse.total)
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
                self.isLoading = false
                // Handle error (e.g., show an alert)
                
            }
        }
    }
    
    func getUniqueSortedTVItems() -> [TVListItem] {
           if let tvList = tvListResponse {
               return Array(Set(tvList.data)).sorted { $0.title < $1.title }
           } else {
               return []
           }
       }
}
