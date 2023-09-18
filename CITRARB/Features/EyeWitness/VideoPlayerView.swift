//
//  VideoPlayerView.swift
//  CITRARB
//
//  Created by Richard Uzor on 16/09/2023.
//

import SwiftUI
import WebKit


struct VideoPlayerView: UIViewRepresentable {
    let reportLink: String


    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let videoURL = URL(string: "\(BASE_NORMAL_URL)\(reportLink)") {
            webView.load(URLRequest(url: videoURL))
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // No need to update
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView(reportLink: "https://citrab.onrender.com/upload-video--16877591099096244.mp4")
    }
}
