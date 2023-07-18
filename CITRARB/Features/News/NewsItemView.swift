//
//  NewsItemView.swift
//  CITRARB
//
//  Created by Richard Uzor on 17/07/2023.
//

import SwiftUI

struct NewsItemView: View {
    
    @StateObject var viewModel = NewsViewModel()
    
    let newsItem: News
    
    
    var body: some View {
        HStack{
            CustomURLImage(urlString: newsItem.cover_photo_small_size)
                .frame(width: 120, height: 70)
                .background(Color.gray)
            Text(newsItem.title)
                .bold()
        }
        .padding(3)
    }
}

struct NewsItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewsItemView(newsItem: .init(author: "Author", category: "category", cover_photo_big_size: "image", cover_photo_small_size: "image", date: "date", description: "description", id: 1, link: "link", title: "title"))
    }
}
