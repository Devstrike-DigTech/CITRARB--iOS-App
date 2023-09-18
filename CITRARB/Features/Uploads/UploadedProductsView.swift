//
//  UploadedProducts.swift
//  CITRARB
//
//  Created by Richard Uzor on 17/09/2023.
//

import SwiftUI

struct UploadedProductsView: View {
    
    @StateObject private var viewModel = MarketPlaceViewModel()
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
                        
                        if let productsList = viewModel.productsListResponse{
                
                            
                            let filteredProducts = productsList.data.filter { productItem in
                                return searchText.isEmpty || productItem.name.localizedCaseInsensitiveContains(searchText) || productItem.userId.username.localizedCaseInsensitiveContains(searchText) ||
                                productItem.category.localizedCaseInsensitiveContains(searchText) ||
                                productItem.description.localizedCaseInsensitiveContains(searchText)
                            }
                            
                            List{
                                // Display the fetched data
                                ForEach(filteredProducts, id: \._id){ productItem in
                                    
                                    displayProductsItems(productItem: productItem)
                                    
                                    
                                }
                            }
                            .sheet(isPresented: $viewModel.isShowingProductItem, onDismiss: {
                                refreshList()
                            }){
                                UploadedProductsSheetView(productItem: viewModel.selectedProductItem!, productItemPresented: $viewModel.isShowingProductItem)
                            }
                            .refreshable {
                                viewModel.requestType = "mine"
                                viewModel.fetchProductsList()
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
            viewModel.fetchProductsList()
        }
    }
    
    
    func displayProductsItems(productItem: Product) -> some View{
        
        ProductItemView(productItem: productItem)
            .onTapGesture {
                viewModel.isShowingProductItem = true
                viewModel.selectedProductItem = IdentifiableProductListItem(id: productItem._id, productItem: productItem)
            }
    }
    
    func refreshList(){
        viewModel.requestType = "mine"
        viewModel.fetchProductsList()
    }
}

struct UploadedProducts_Previews: PreviewProvider {
    static var previews: some View {
        UploadedProductsView()
    }
}
