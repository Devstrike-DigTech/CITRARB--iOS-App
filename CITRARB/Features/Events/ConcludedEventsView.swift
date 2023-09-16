//
//  ConcludedEventsView.swift
//  CITRARB
//
//  Created by Richard Uzor on 12/09/2023.
//

import SwiftUI

struct ConcludedEventsView: View {
    
    @StateObject private var viewModel = EventsViewModel()
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
                        
                        if let eventsList = viewModel.eventsListResponse{
                            
                            let upcomingTimeFilteredList = eventsList.data.filter{ eventItem in
                                return !isDateInFuture(dateString: eventItem.time)
                            }
                            
                            let filteredEvents = upcomingTimeFilteredList.filter { eventItem in
                                return searchText.isEmpty || eventItem.name.localizedCaseInsensitiveContains(searchText) || eventItem.host.username.localizedCaseInsensitiveContains(searchText) ||
                                eventItem.location.localizedCaseInsensitiveContains(searchText) ||
                                eventItem.description.localizedCaseInsensitiveContains(searchText)
                            }
                            
                            List{
                                // Display the fetched data
                                ForEach(filteredEvents, id: \._id){ eventItem in
                                    
                                    displayEventsItems(eventItem: eventItem)
                                    
                                    
                                }
                            }
                            .sheet(item: $viewModel.selectedEventItem){ identifiableEventListItem in
                                EventsSheetView(eventItem: identifiableEventListItem.eventItem)
                            }
                            .refreshable {
                                viewModel.fetchEventsList()
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
            viewModel.fetchEventsList()
        }
    }
    
    func isDateInFuture(dateString: String) -> Bool{
        // Your date string
        
        // Create a DateFormatter to parse the date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        // Parse the date string into a Date object
        if let date = dateFormatter.date(from: dateString) {
            // Get the current date
            let currentDate = Date()
            
            // Compare the parsed date with the current date
            if date > currentDate {
                print("The date is in the future.")
                return true
            } else {
                print("The date is not in the future.")
                return false
            }
        }
        return false
    }
    
    func displayEventsItems(eventItem: Event) -> some View{
        
        EventItemView(eventItem: eventItem)
            .onTapGesture {
                viewModel.isShowingEventItem = true
                viewModel.selectedEventItem = IdentifiableEventListItem(id: eventItem._id, eventItem: eventItem)
            }
    }
}

struct ConcludedEventsView_Previews: PreviewProvider {
    static var previews: some View {
        ConcludedEventsView()
    }
}
