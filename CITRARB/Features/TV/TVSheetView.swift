//
//  TVSheetView.swift
//  CITRARB
//
//  Created by Richard Uzor on 02/08/2023.
//

import SwiftUI
import YouTubePlayerKit
import SwiftUIYouTubePlayer



struct TVSheetView: View {
    let tvItem: TVListItem
 
    var body: some View {
    
        VStack{
    
            YouTubePlayerView(videoID: extractVideoID(from: tvItem.Link)!)
                .frame(height: 300)
            Text("\(tvItem.title)")
                .bold()
                .scenePadding()
            Text("\(tvItem.description)")
            Spacer()
        }
        .padding(4)
       }
    
        
}



struct TVSheetView_Previews: PreviewProvider {
    static var previews: some View {
        TVSheetView(tvItem: TVListItem(Link: "https://www.youtube.com/watch?v=0Yqom16tzcw", description: "Music video by King Promise performing Terminator (Official Video). (C) 2023 under exclusive licence to 5K Records Limited / Sony Music Entertainment UK Limited http://vevo.ly/ZYSb0U", publishedAt: "Jul 17, 2023", thumbnails: Thumbnails(high: Metric(height: 32, width: 32), maxres: Metric(height: 32, width: 32), medium: Metric(height: 32, width: 32), standard: Metric(height: 32, width: 32)), title: extractVideoID(from: "https://www.youtube.com/watch?v=vEurDtL6EnM")!))
    }
}

private func extractVideoID(from url: String) -> String? {
    guard let url = URLComponents(string: url) else { return nil }
    
    if let queryItem = url.queryItems?.first(where: { $0.name == "v" }) {
        return queryItem.value
    } else {
        return nil
    }
}
