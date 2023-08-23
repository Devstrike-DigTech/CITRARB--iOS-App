//
//  MembersView.swift
//  CITRARB
//
//  Created by Richard Uzor on 23/08/2023.
//

import SwiftUI
import SlidingTabView

struct MembersView: View {
    @State private var tabIndex = 0
    var body: some View {
        VStack{
            SlidingTabView(selection: $tabIndex, tabs: ["Friends", "All Members"], animation: .easeInOut, activeAccentColor: MEMBERS_COLOR, selectionBarColor: MEMBERS_COLOR)
            Spacer()
            
            if tabIndex == 0{
                FriendsView()
            }else if tabIndex == 1{
                AllMembersView()
            }
            
            Spacer()
        }
    }
}

struct MembersView_Previews: PreviewProvider {
    static var previews: some View {
        MembersView()
    }
}
