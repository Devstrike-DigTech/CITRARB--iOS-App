//
//  ToastView.swift
//  CITRARB
//
//  Created by Richard Uzor on 19/09/2023.
//

import SwiftUI

struct ToastView: View {
    var text: String
       @Binding var isPresented: Bool

       var body: some View {
           Text(text)
               .padding()
               .background(Color.secondary)
               .foregroundColor(.white)
               .cornerRadius(10)
               .onAppear {
                   DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                       isPresented = false
                   }
               }
       }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView(text: "This is a toast", isPresented: Binding(get: {
            return true
        }, set: { _ in
            
        }) )
    }
}
