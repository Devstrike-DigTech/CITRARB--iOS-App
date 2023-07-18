//
//  NewsViewModel.swift
//  CITRARB
//
//  Created by Richard Uzor on 17/07/2023.
//

import Foundation

class NewsViewModel: ObservableObject{
    
    @Published var news: [News] = []
    
    func fetchNews(){
        
    }
    
}
