//
//  RegisterView.swift
//  CITRARB
//
//  Created by Richard Uzor on 17/07/2023.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack{
            HeaderView(title: "Register", subTitle: "Enter your details to register",  background: .orange)
            
            Form{
                if !viewModel.errorMessage.isEmpty{
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                }
                TextField("Username", text:  $viewModel.username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                
                TextField("Email Address", text:  $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                
                SecureField("Confirm Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 4, trailing: 16))
            
            TLButton(btnText: "Sign Up", backgoundColor: .blue, width: 256){
                viewModel.login()
            }
            
            
            //Create Account
            VStack{
                Text("Have an account?")
                NavigationLink("Login Instead", destination: LoginView())
                
            }.padding(.bottom, 50)
            //Spacer()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
