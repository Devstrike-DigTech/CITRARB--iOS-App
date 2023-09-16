//
//  ProductSheetView.swift
//  CITRARB
//
//  Created by Richard Uzor on 07/09/2023.
//

import SwiftUI

struct ProductSheetView: View {
    
    let productItem: Product
    
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    
    var body: some View {
        VStack{
            //put carousel of images here
        
            HStack{
                Text(productItem.name).font(.title2)
                Spacer()
                
                productActionImages(systemImageName: "message.fill"){ messageConnect(phoneNumber: productItem.userId.phone ?? "0")}
                productActionImages(systemImageName: "phone.fill"){ makeCall(phoneNumber: productItem.userId.phone ?? "0")}
                productActionImages(systemImageName: "square.and.arrow.up.fill"){ shareConnect(phoneNumber: productItem.userId.phone ?? "0")}
                
            }
            .padding(8)
            .foregroundColor(.black)
            .shadow(color: .black,radius: 120)
            
            
            Text("₦\(productItem.price)").frame(maxWidth: .infinity, alignment: .leading).padding(4)
            Text(productItem.userId.username).frame(maxWidth: .infinity, alignment: .leading).padding(4)
            Text(productItem.category).frame(maxWidth: .infinity, alignment: .leading).padding(4)
            Text(productItem.description).frame(maxWidth: .infinity, alignment: .leading).padding(4)
            
            
        }
        .padding(8)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Alert Title"),
                message: Text(alertMessage),
                primaryButton: .default(Text("OK")) {
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


struct ProductSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ProductSheetView(productItem: Product(_id: "123", price: 200, name: "Product Name", category: "Gadgets", images: ["https://fastly.picsum.photos/id/9/5000/3269.jpg?hmac=cZKbaLeduq7rNB8X-bigYO8bvPIWtT-mh8GRXtU3vPc"], description: "description", active: true, userId: ProductUser(_id: "123", username: "product owner", email: "a@e.com", role: "user", photo: "https://fastly.picsum.photos/id/9/5000/3269.jpg?hmac=cZKbaLeduq7rNB8X-bigYO8bvPIWtT-mh8GRXtU3vPc", createdAt: "07-Aug-2023", updatedAt: "07-Sep-2023", __v: 1, gender: "Male", phone: "08132665650")))
    }
}
