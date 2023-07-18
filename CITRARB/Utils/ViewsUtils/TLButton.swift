//
//  TLButton.swift
//  ToDoList
//
//  Created by Richard Uzor on 24/06/2023.
//

import SwiftUI

struct TLButton: View {
    
    let btnText: String
    let backgoundColor: Color
    let width: Double
    let action: () -> Void
    var body: some View {
        
        Button{
            action()
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 10).foregroundColor(backgoundColor)
                Text(btnText).bold()
                    .foregroundColor(Color.white)
            }
        }.frame(width: width, height: 40)
    }
}

struct TLButton_Previews: PreviewProvider {
    static var previews: some View {
        TLButton(btnText: "Button", backgoundColor: .blue, width: 256, action: {
            //Button Action
        })
    }
}
