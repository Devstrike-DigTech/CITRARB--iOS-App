//
//  ProfileView.swift
//  CITRARB
//
//  Created by Richard Uzor on 17/07/2023.
//

import SwiftUI
import CachedAsyncImage


struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()

    var body: some View {
        NavigationView{
            
        }.onAppear{
            
        }
        .navigationTitle("Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
