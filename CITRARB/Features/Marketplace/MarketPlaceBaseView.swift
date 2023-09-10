//
//  MarketPlaceBaseView.swift
//  CITRARB
//
//  Created by Richard Uzor on 07/09/2023.
//

import SwiftUI
import SlidingTabView


struct MarketPlaceBaseView: View {
    
    @StateObject private var viewModel = MarketPlaceViewModel()

    @State private var tabIndex = 0
    var body: some View {
        NavigationView{
            VStack{
                SlidingTabView(selection: $tabIndex, tabs: ["Gadget", "Clothing", "Foods", "Others"], animation: .easeInOut, activeAccentColor: MARKET_PLACE_COLOR, selectionBarColor: MARKET_PLACE_COLOR)
                Spacer()
                
                if tabIndex == 0{
                    MarketPlaceProductsView(tag: "Gadget")
                }else if tabIndex == 1{
                    MarketPlaceProductsView(tag: "Clothing")
                }else if tabIndex == 2{
                    MarketPlaceProductsView(tag: "Foods")
                }else if tabIndex == 3{
                    MarketPlaceProductsView(tag: "Others")
                }
                
                Spacer()
            }
        }.navigationBarTitle("Marketplace")
            .toolbar{
                Button{
                    viewModel.showingNewItemView.toggle()
                }label: {
                    Text("Add Product")
                }
            }
                .sheet(isPresented: $viewModel.showingNewItemView){
                 NewProductView(newItemPresented: self.$viewModel.showingNewItemView)
            }
    }
}

struct MarketPlaceBaseView_Previews: PreviewProvider {
    static var previews: some View {
        MarketPlaceBaseView()
    }
}
