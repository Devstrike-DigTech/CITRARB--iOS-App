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
    @Binding var loginItemPresented: Bool

    
    var body: some View {
        
        NavigationView{
            ZStack{
              
                VStack{
                    //Header
                    HeaderView(title: "Login", subTitle: "Enter details to login", background: .pink)
                    //Login Form
                    Form{
                        if ((viewModel.error?.isEmpty) == false){
                            Text(viewModel.error ?? "")
                                .foregroundColor(.red)
                        }
                        Section(header: Text("Enter Email Address")){
                            TextField("Email Address", text: $email)
                        }
                        
                        Section(header: Text("Enter Password")){
                            
                            SecureField("Password", text: $password)
                            
                        }
                        
                        TLButton(btnText: "Log In", backgoundColor: .blue, width: 256){
                            viewModel.login(email: email, password: password)
                            loginItemPresented = false
                        }.frame(maxWidth: .infinity, alignment: .center)
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 4, trailing: 16))
                        
                        
                        //Create Account
                        VStack{
                            Text("New around here?")
                                .padding()
                                .onTapGesture {
                                    loginItemPresented = false
                                }
                            Text("Create an account")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    viewModel.isShowingRegister.toggle()
                                }.sheet(isPresented: $viewModel.isShowingRegister){
                                    RegisterView(registerItemPresented: $viewModel.isShowingRegister)
                                }
                            //NavigationLink("Create An Account", destination: RegisterView())
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                    if let error = viewModel.error {
                                  Text(error)
                                      .foregroundColor(.red)
                              }
              
                  
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
        LoginView(loginItemPresented: Binding(get: {
            return true
        }, set: { _ in
            
        }))
    }
}
