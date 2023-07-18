//
//  LoginView.swift
//  CITRARB
//
//  Created by Richard Uzor on 17/07/2023.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        
        NavigationView{
            VStack{
                //Header
                HeaderView(title: "Login", subTitle: "Enter details to login", background: .pink)
                //Login Form
                Form{
                    if !viewModel.errorMessage.isEmpty{
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                    }
                    TextField("Email Address", text:  $viewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    
                }.padding(EdgeInsets(top: 0, leading: 16, bottom: 4, trailing: 16))
                
                TLButton(btnText: "Log In", backgoundColor: .blue, width: 256){
                    viewModel.login()
                }
                
                
                //Create Account
                VStack{
                    Text("New around here?")
                    NavigationLink("Create An Account", destination: RegisterView())
                    
                }.padding(.bottom, 50)
                Spacer()
            }
        } .navigationTitle("Login")
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
