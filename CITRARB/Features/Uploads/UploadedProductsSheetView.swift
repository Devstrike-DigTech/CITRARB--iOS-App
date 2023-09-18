//
//  UploadedProductsSheetView.swift
//  CITRARB
//
//  Created by Richard Uzor on 17/09/2023.
//

import SwiftUI

struct UploadedProductsSheetView: View {
    
    let productItem: IdentifiableProductListItem
    @Binding var productItemPresented: Bool

    
    @StateObject private var viewModel = MarketPlaceViewModel()

    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    
    var body: some View {
        VStack{
            //put carousel of images here
        
            HStack{
                Text(productItem.productItem.name).font(.title2)
                Spacer()
                
            }
            .padding(8)
            .foregroundColor(.black)
            .shadow(color: .black,radius: 120)
            
            
            Text("₦\(productItem.productItem.price)").frame(maxWidth: .infinity, alignment: .leading).padding(4)
            Text(productItem.productItem.category).frame(maxWidth: .infinity, alignment: .leading).padding(4)
            Text(productItem.productItem.description).frame(maxWidth: .infinity, alignment: .leading).padding(4)
//            Text("Date Uploaded: \(productItem.productItem.createdAt)").frame(maxWidth: .infinity, alignment: .leading).padding(4)
//            Text("Time Uploaded: \(productItem.productItem.createdAt)").frame(maxWidth: .infinity, alignment: .leading).padding(4)
            
            Text("Delete")
                .foregroundColor(.red).fontWeight(.bold)
                .padding()
                .onTapGesture {
                    showAlert = true
                    alertMessage = "Sure to delete this product?"
                }
        }
        .padding(8)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Delete Product").fontWeight(.bold),
                message: Text(alertMessage),
                primaryButton: .default(Text("Yes").foregroundColor(.red)) {
                    viewModel.deleteProduct(productId: productItem.productItem._id)
                    productItemPresented = false
                    showAlert = false // Close the alert when OK is tapped
                },
                secondaryButton: .cancel() {
                    showAlert = false // Close the alert when Cancel is tapped
                }
            )
        }
    }
    
    
    func productActionImages(systemImageName: String, action: @escaping() -> Void) -> some View{
        Image(systemName: "\(systemImageName)").padding(4).font(.title2).foregroundColor(MARKET_PLACE_COLOR)
            .padding(8)
            .foregroundColor(.black)
            .shadow(color: .black,radius: 120)
            .onTapGesture {
                action()
            }
        
    }
    
    
    
    func makeCall(phoneNumber: String){
        if let phoneURL = URL(string: "tel://\(phoneNumber)") {
            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        }
        //showAlert = true
        //alertMessage = "Call Clicked!"
    }
    func shareConnect(phoneNumber: String){
        showAlert = true
        alertMessage = "Share Clicked!"
    }
    func messageConnect(phoneNumber: String){
        showAlert = true
        alertMessage = "Message Clicked!"
    }
}

//struct UploadedProductsSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        UploadedProductsSheetView()
//    }
//}
