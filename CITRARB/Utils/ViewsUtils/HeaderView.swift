//
//  HeaderView.swift
//  ToDoList
//
//  Created by Richard Uzor on 23/06/2023.
//

import SwiftUI

struct HeaderView: View {
    
    let title: String
    let subTitle: String
    let background: Color
    
    var body: some View {
            VStack{
                Text(title)
                    .font(.system(size: 32))
                    .foregroundColor(Color.black)
                    .bold()
                Text(subTitle)
                    .font(.system(size: 16))
                    .foregroundColor(Color.black)
            }
            .padding(.top, 80)
        
        .frame(width: UIScreen.main.bounds.width * 3, height: 350)
        .offset(y: -150)

    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Title", subTitle: "Subtitle",  background: .blue)
    }
}
