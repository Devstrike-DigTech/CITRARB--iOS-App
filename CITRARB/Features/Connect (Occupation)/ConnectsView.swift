//
//  ConnectsView.swift
//  CITRARB
//
//  Created by Richard Uzor on 04/09/2023.
//

import SwiftUI
import SlidingTabView


struct ConnectsView: View {
    @StateObject private var viewModel = ConnectsViewModel()

    @State private var tabIndex = 0
    
    var body: some View {
        NavigationView{
            VStack{
                SlidingTabView(selection: $tabIndex, tabs: ["Tech", "Health", "Artisans", "Others"], animation: .easeInOut, activeAccentColor: CONNECT_COLOR, selectionBarColor: CONNECT_COLOR)
                Spacer()
                
                if tabIndex == 0{
                    AllConnectsView(tag: "Tech")
                }else if tabIndex == 1{
                    AllConnectsView(tag: "Medical")
                }else if tabIndex == 2{
                    AllConnectsView(tag: "Service")
                }else if tabIndex == 3{
                    AllConnectsView(tag: "Others")
                }
                
                Spacer()
            }
        }.navigationBarTitle("Connects")
            .toolbar{
                Button{
                    viewModel.showingNewItemView.toggle()
                }label: {
                    Text("Add Occupation")
                }
            }.sheet(isPresented: $viewModel.showingNewItemView){
                NewConnectView(newItemPresented: self.$viewModel.showingNewItemView)
            }
    }
}

struct ConnectsView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectsView()
    }
}
