//
//  RegisterView.swift
//  CITRARB
//
//  Created by Richard Uzor on 17/07/2023.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = ProfileViewModel()
    
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    
    var body: some View {
        VStack{
            HeaderView(title: "Register", subTitle: "Enter your details to register",  background: .orange)
            
            
            if ((viewModel.error?.isEmpty) == false){
                Text(viewModel.error ?? "")
                        .foregroundColor(.red)
                }
                TextField("Username", text:  $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 4, trailing: 16))
                
                TextField("Email Address", text:  $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 4, trailing: 16))
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 4, trailing: 16))
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 4, trailing: 16))
                
            
            //.padding(EdgeInsets(top: 0, leading: 16, bottom: 4, trailing: 16))
            
            TLButton(btnText: "Sign Up", backgoundColor: .blue, width: 256){
                viewModel.register(username: username, email: email, password: password, confirmPassword: confirmPassword)
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 4, trailing: 16))
            
            
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
