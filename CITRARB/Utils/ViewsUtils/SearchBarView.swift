//
//  SearchBarView.swift
//  CITRARB
//
//  Created by Richard Uzor on 03/09/2023.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    
    var body: some View {
        ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(radius: 3)

                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.leading, 10)

                        TextField("Search", text: $text)
                            .padding(10)
                            .font(.body)
                            .foregroundColor(.black)
                            .autocapitalization(.none)

                        if !text.isEmpty {
                            Button(action: {
                                text = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 10)
                            }
                        }
                    }
                }
                .frame(height: 40)
                .padding(.horizontal, 20)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    @State static var searchText: String = ""
    static var previews: some View {
        SearchBarView(text: $searchText)
    }
}
