//
//  ProductItemView.swift
//  CITRARB
//
//  Created by Richard Uzor on 07/09/2023.
//

import SwiftUI
import CachedAsyncImage


struct ProductItemView: View {
    
    let productItem: Product
    
    var body: some View {
        HStack{
            //use the cachedasyncimage library to load and cache the news image from the url
            CachedAsyncImage(url: URL(string: "\(BASE_NORMAL_URL) \(productItem.images.first!)"),
                             transaction: Transaction(animation: .easeInOut)){ phase in
                //set an animation to display the placeholder image
                if let image = phase.image{
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .transition(.opacity)
                        .frame(width: 120, height: 240)
                        .padding(4)
                }else{
                    HStack{
                        ProgressView()
                    }
                    
                }
            }
            VStack{
                Text(productItem.name)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading).padding(4)
                
                Text("₦\(productItem.price)")
                    .fontWeight(.regular)
                    .frame(maxWidth: .infinity, alignment: .leading).padding(4)
                
                Text(productItem.userId.username)
                    .fontWeight(.regular)
                    .frame(maxWidth: .infinity, alignment: .leading).padding(4)
                
                
            }
            .padding()
        }
    }
}

struct ProductItemView_Previews: PreviewProvider {
    static var previews: some View {
        
        ProductItemView(productItem: Product(_id: "123", price: 200, name: "Product Name", category: "Gadgets", images: ["https://citrab.onrender.com/product--1694312741563-2.jpeg"], description: "description", active: true, userId: ProductUser(_id: "123", username: "product owner", email: "a@e.com", role: "user", photo: "https://fastly.picsum.photos/id/9/5000/3269.jpg?hmac=cZKbaLeduq7rNB8X-bigYO8bvPIWtT-mh8GRXtU3vPc", createdAt: "07-Aug-2023", updatedAt: "07-Sep-2023", __v: 1, gender: "Male", phone: "08132665650")))
    }
}
