//
//  LoginView.swift
//  CITRARB
//
//  Created by Richard Uzor on 17/07/2023.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        
        NavigationView{
            ZStack{
              
                VStack{
                    //Header
                    HeaderView(title: "Login", subTitle: "Enter details to login", background: .pink)
                    //Login Form
                    //Form{
                    if ((viewModel.error?.isEmpty) == false){
                        Text(viewModel.error ?? "")
                                .foregroundColor(.red)
                        }
                        TextField("Email Address", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                            .padding()
                        
                        SecureField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                            .padding()
                        
                    //}.padding(EdgeInsets(top: 0, leading: 16, bottom: 4, trailing: 16))
                  
                    
                    if let error = viewModel.error {
                                  Text(error)
                                      .foregroundColor(.red)
                              }
                    
                    TLButton(btnText: "Log In", backgoundColor: .blue, width: 256){
                        viewModel.login(email: email, password: password)
                    }
                    
                    
                    //Create Account
                    VStack{
                        Text("New around here?")
                            .padding()
                        NavigationLink("Create An Account", destination: RegisterView())
                        
                    }.padding(.bottom, 50)
                    Spacer()
                }
                
//                if viewModel.isLoading == false{
//
//                }
//                else {
//                    // Show a loading view or error message while data is being fetched
//                    VStack{
//                        LottieView(filename: "loading")
//                            .frame(width: 120,  height: 120)
//                    }
//
//                }
                
            }
    
        } .navigationTitle("Login")
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
