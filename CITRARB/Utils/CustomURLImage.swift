//
//  CustomURLImage.swift
//  ApiCallTutorial
//
//  Created by Richard Uzor on 17/07/2023.
//

import Foundation
import SwiftUI

struct CustomURLImage: View{
    
    //we create a custom struct to load images from a fetched data or display a placeholder if no image was found
    //using this also makes our app compatible with lower iOS version devices
    
    let urlString: String
    
    //we create a state variable to represent the fetched data
    //cos it is a state data, whenever it changes, the view will practically redraw itself
    @State var data: Data?
    
    var body: some View{
        if let data = data, let uiimage = UIImage(data: data){
            //if there is a fetched data, display it
            //the UIImage library used converts an image string to bytes (or bitmap)
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 130, height: 70)
                .background(Color.gray)
        }else{
            //placeholder for if there is no image in the fetched data
            Image(systemName: "news")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 130, height: 70)
                .background(Color.gray)
                .onAppear{
                    fetchData()
                }
        }
    }
    
    //we create a function to fetch the data from the api
    private func fetchData(){
        guard let url = URL(string: urlString) else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ data, _, _ in
            //ignore the response action and error in this call, cos if there is any other result apart from the data, the placeholder will simply be displayed
            self.data = data
        }
        task.resume() //don't forget to set off the api call
    }
}
