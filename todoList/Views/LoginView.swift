//
//  LoginView.swift
//  todoList
//
//  Created by Trey Bertram on 2023-09-17.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                //Header
                HeaderView(title: "To Do List",
                           subtitle: "",
                           angle: 15,
                           background: Color("tameYellow"))

                
                
                //Login form
                Form {
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red)
                    }
                    
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(.none)
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    ButtonView(title: "Login",
                               background: .blue) {
                        viewModel.login()
                    }

                }
                .offset(y: -50)

                
                //Create Account
                VStack {
                    Text("New Around Here?")
                    NavigationLink("Registration", destination: RegistrationView())
                }
                .padding(.bottom, 50)
                
                Spacer()
            }
        }

        }
    }

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
