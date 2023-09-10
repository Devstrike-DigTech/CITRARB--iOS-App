//
//  NewProductView.swift
//  CITRARB
//
//  Created by Richard Uzor on 07/09/2023.
//

import SwiftUI

struct NewProductView: View {
    @StateObject var viewModel = MarketPlaceViewModel()
    
    @Binding var newItemPresented: Bool
    @State var isShowing = false
    
    @State var image1 = "Pick Product Image 1"
    @State var image2 = "Pick Product Image 2"
    @State var image3 = "Pick Product Image 3"
    @State private var isPickingImage1 = false
       @State private var isPickingImage2 = false
       @State private var isPickingImage3 = false
    
    
    
    let productCategories = ["Gadget", "Clothing", "Food", "Others"]
    
    //name
    //category
    //title
    //phone
    //description
    var charCount: Int {
        viewModel.productDescription.filter { $0 != " " }.count
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    
                    Text("Add Your Product")
                        .font(.title)
                        .fontWeight(.heavy)
                        .padding()
                    //                if viewModel.isLoading == false{
                    Form{
                        Section(header: Text("Enter Product Name")){
                            VStack{
                                TextField("Product Name", text: $viewModel.productName)
                            }
                        }
                        //                    //                - - - - - this makes it a dropdown menu - - - - - -
                        Section(header: Text("Select Product Category")){
                            VStack{
                                Picker("Product Category", selection: $viewModel.productCategory){
                                    ForEach(productCategories, id: \.self){ option in
                                        Text((option)).tag(option)
                                    }
                                }.pickerStyle(SegmentedPickerStyle())
                            }
                        }
                        
                        Section(header: Text("Enter Product Price (₦)")){
                            VStack{
                                TextField("Product Price", text: $viewModel.productPrice).keyboardType(.numberPad)
                            }
                            
                        }
                        Section(header: Text("Enter Product Description (min 25 chars):"), content: {
                            VStack {
                                ScrollView{
                                    TextEditor(text: $viewModel.productDescription).lineLimit(3)
                                        .frame(width: 300, height: 100)
                                }
                                //                            let charCount = $viewModel.description.filter {$0 != " "}.count
                                //
                                if charCount < 25 {
                                    Text(String(charCount)).foregroundColor(.red)
                                } else {
                                    Text(viewModel.productDescription.isEmpty ? "0" : String(charCount))                            }
                            }
                        })
//                        if viewModel.selectedFile1 != nil {
//                                 Image(systemName: "photo")
//                                     .resizable()
//                                     .frame(width: 100, height: 100)
//                                     .onTapGesture {
//                                         isPickingImage1.toggle()
//                                     }
//                                     .fileImporter(
//                                         isPresented: $isPickingImage1,
//                                         allowedContentTypes: [.image],
//                                         allowsMultipleSelection: false
//                                     ) { result in
//                                         do {
//                                             viewModel.selectedFile1 = try result.get().first
//                                         } catch {
//                                             // Handle error
//                                             print("Error picking image 1: \(error)")
//                                         }
//                                     }
//                             } else {
//                                 Button(action: {
//                                     isPickingImage1.toggle()
//                                 }) {
//                                     Text("Pick Image 1")
//                                 }
//                             }

//                        viewModel.selectedFile2 {
                        
                                    Text("\(image1)")
                                        .onTapGesture {
                                            isPickingImage1.toggle()
                                        }
                                        .fileImporter(
                                            isPresented: $isPickingImage1,
                                            allowedContentTypes: [.image],
                                            allowsMultipleSelection: false
                                        ) { result in
                                            do {
                                                viewModel.selectedFile1 = try result.get().first
                                                image1 = viewModel.selectedFile1!.lastPathComponent
                                            } catch {
                                                // Handle error
                                                print("Error picking image 1: \(error)")
                                            }
                                        }
                                        .foregroundColor(.blue)
                        
                        
                                    Text("\(image2)")
                                        .onTapGesture {
                                            isPickingImage2.toggle()
                                        }
                                        .fileImporter(
                                            isPresented: $isPickingImage2,
                                            allowedContentTypes: [.image],
                                            allowsMultipleSelection: false
                                        ) { result in
                                            do {
                                                viewModel.selectedFile2 = try result.get().first
                                                image2 = viewModel.selectedFile2!.lastPathComponent
                                            } catch {
                                                // Handle error
                                                print("Error picking image 2: \(error)")
                                            }
                                        }
                                        .foregroundColor(.blue)
                        
                        
                                    Text("\(image3)")
                                        .onTapGesture {
                                            isPickingImage3.toggle()
                                        }
                                        .fileImporter(
                                            isPresented: $isPickingImage3,
                                            allowedContentTypes: [.image],
                                            allowsMultipleSelection: false
                                        ) { result in
                                            do {
                                                viewModel.selectedFile3 = try result.get().first
                                                image3 = viewModel.selectedFile3!.lastPathComponent
                                            } catch {
                                                // Handle error
                                                print("Error picking image 3: \(error)")
                                            }
                                        }
                                        .foregroundColor(.blue)
                        
                        
                                //}
//                        else {
//                                    Button(action: {
//                                        isPickingImage2.toggle()
//                                    }) {
//                                        Text("Pick Image 2")
//                                    }
//                                }
                        
//                        Button {
//                            isShowing.toggle()
//                        } label: {
//                            Text("\(image1)")
//                        }
//                        .fileImporter(isPresented: $isShowing, allowedContentTypes: [.item], allowsMultipleSelection: false, onCompletion: { results1 in
//
//                            switch results1 {
//                            case .success(let fileurls1):
//                                print(fileurls1.count)
//
//                                for fileurl1 in fileurls1 {
//                                    print(fileurl1.path)
//                                    image1 = fileurl1.lastPathComponent
//                                    viewModel.selectedFile1 = fileurl1
//
//                                }
//
//                            case .failure(let error):
//                                print(error)
//                            }
//
//                        })
//                        Button {
//                            isShowing.toggle()
//                        } label: {
//                            Text("\(image2)")
//                        }
//                        .fileImporter(isPresented: $isShowing, allowedContentTypes: [.item], allowsMultipleSelection: false, onCompletion: { results2 in
//
//                            switch results2 {
//                            case .success(let fileurls2):
//                                print(fileurls2.count)
//
//                                for fileurl2 in fileurls2 {
//                                    print(fileurl2.path)
//                                    image2 = fileurl2.lastPathComponent
//                                    viewModel.selectedFile2 = fileurl2
//
//                                }
//
//                            case .failure(let error):
//                                print(error)
//                            }
//
//                        })
//                        Button {
//                            isShowing.toggle()
//                        } label: {
//                            Text("\(image3)")
//                        }
//                        .fileImporter(isPresented: $isShowing, allowedContentTypes: [.item], allowsMultipleSelection: false, onCompletion: { results3 in
//
//                            switch results3 {
//                            case .success(let fileurls3):
//                                print(fileurls3.count)
//
//                                for fileurl3 in fileurls3 {
//                                    print(fileurl3.path)
//                                    image3 = fileurl3.lastPathComponent
//                                    viewModel.selectedFile3 = fileurl3
//
//                                }
//
//                            case .failure(let error):
//                                print(error)
//                            }
//
//                        })
//
                        Button("Add Product"){
                            if viewModel.canSave(){
                                viewModel.uploadFile()
                                newItemPresented = false
                                
                            }else{
                                viewModel.showAlert = true
                            }
                            //close sheet
                        }
                        
                        .foregroundColor(MARKET_PLACE_COLOR)
                        .fontWeight(.bold)
                        .frame(width: 320)
                        .shadow(color: MARKET_PLACE_COLOR,radius: 8)
                        
                    }
                }
            }
                if viewModel.isLoading{
                    // Show the progress (you can use a Text view or a ProgressBar)
                            Text("Upload Progress: \(Int(viewModel.uploadProgress * 100))%")
                }
        }
        .alert(isPresented: $viewModel.showAlert){
            Alert(title: Text("Error"), message: Text(viewModel.error!))
        }            .navigationTitle("Add Your Product")
        
    }
    
}

struct NewProductView_Previews: PreviewProvider {
    static var previews: some View {
        NewProductView(newItemPresented: Binding(get: {
            return true
        }, set: { _ in
            
        }) )
    }
}
