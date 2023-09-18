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
    @Binding var registerItemPresented: Bool
    
    
    
    var body: some View {
        VStack{
            HeaderView(title: "Register", subTitle: "Enter your details to register",  background: .orange)
            Form{
                
                Section(header: Text("Enter Username")){
                    TextField("Username", text:  $username)
                }
                Section(header: Text("Enter Email Address")){
                    TextField("Email Address", text:  $email)
                }
                Section(header: Text("Enter Password")){
                    SecureField("Password", text: $password)
                }
                Section(header: Text("Retype Password")){
                    SecureField("Confirm Password", text: $confirmPassword)
                }
                
                TLButton(btnText: "Sign Up", backgoundColor: .blue, width: 256){
                    viewModel.register(username: username, email: email, password: password, confirmPassword: confirmPassword)
                    registerItemPresented = false
                }                        .frame(maxWidth: .infinity, alignment: .center)
                
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 4, trailing: 16))
                
                VStack{
                    Text("Have an account?")
                    Text("Login Instead")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            viewModel.isShowingRegister.toggle()
                            viewModel.isShowingLogin.toggle()
                        }.sheet(isPresented: $viewModel.isShowingRegister){
                            LoginView(loginItemPresented: $viewModel.isShowingLogin)
                        }
                    //NavigationLink("Login Instead", destination: LoginView(loginItemPresented: true))
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 4, trailing: 16))
                
            }
            //
            
            if ((viewModel.error?.isEmpty) == false){
                Text(viewModel.error ?? "")
                    .foregroundColor(.red)
            }
            
            
            
            //.padding(EdgeInsets(top: 0, leading: 16, bottom: 4, trailing: 16))
            
            
            //Create Account
            
            //.padding(.bottom, 50)
            //Spacer()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(registerItemPresented: Binding(get: {
            return true
        }, set: { _ in
            
        }))
    }
}
