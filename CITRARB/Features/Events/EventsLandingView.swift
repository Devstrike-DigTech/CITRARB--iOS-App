//
//  EventsLandingView.swift
//  CITRARB
//
//  Created by Richard Uzor on 11/09/2023.
//

import SwiftUI
import SlidingTabView


struct EventsLandingView: View {
    
    @StateObject private var viewModel = EventsViewModel()

    @State private var tabIndex = 0
    
    var body: some View {
        NavigationView{
            VStack{
                SlidingTabView(selection: $tabIndex, tabs: ["Upcoming", "Concluded"], animation: .easeInOut, activeAccentColor: EVENTS_COLOR, selectionBarColor: EVENTS_COLOR)
                Spacer()
                
                if tabIndex == 0{
                    UpcomingEventsView()
                }else if tabIndex == 1{
                    ConcludedEventsView()
                }
                
                Spacer()
            }
        }.navigationBarTitle("Events")
            .toolbar{
                Button{
                    viewModel.showingNewItemView.toggle()
                }label: {
                    Text("Add Event")
                }
            }
                .sheet(isPresented: $viewModel.showingNewItemView){
                 NewEventSheetView(newItemPresented: self.$viewModel.showingNewItemView)
            }
    }
}

struct EventsLandingView_Previews: PreviewProvider {
    static var previews: some View {
        EventsLandingView()
    }
}
