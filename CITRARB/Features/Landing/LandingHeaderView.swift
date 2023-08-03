//
//  LandingHeaderView.swift
//  CITRARB
//
//  Created by Richard Uzor on 18/07/2023.
//

import SwiftUI

struct LandingHeaderView: View {
    var body: some View {
        NavigationView{
            HStack(alignment: .top){
                Text(APP_NAME)
                    .bold()
                    .font(.title)
                Image(systemName: "person.circle.fill")
                    .frame(alignment: .trailing)
                    .font(.largeTitle)
                Image(systemName: "person.circle.fill")
                    .font(.largeTitle)
                    .frame(alignment: .trailing)
            }
            .padding()
            
            
        }
        
        
        
    }
}

struct LandingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        LandingHeaderView()
    }
}
