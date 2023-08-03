//
//  YouTubePlayerView.swift
//  CITRARB
//
//  Created by Richard Uzor on 02/08/2023.
//

import SwiftUI
import WebKit


struct YouTubePlayerView: UIViewRepresentable {
    let videoID: String


    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let videoURL = URL(string: "https://www.youtube.com/embed/\(videoID)") {
            webView.load(URLRequest(url: videoURL))
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // No need to update
    }
    
//    func extractVideoID(from url: String) -> String? {
//        if let urlComponents = URLComponents(string: url),
//           let queryItems = urlComponents.queryItems,
//           let videoID = queryItems.first(where: { $0.name == "v" })?.value {
//            print("\(videoID)")
//            return videoID
//        }
//        return nil
//    }
}

struct YouTubePlayerView_Previews: PreviewProvider {
    static var previews: some View {
        YouTubePlayerView(videoID: "0Yqom16tzcw")
    }
}

