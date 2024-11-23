//
//  RegistrationView.swift
//  todoList
//
//  Created by Trey Bertram on 2023-09-17.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject var viewModel = RegistrationViewViewModel()

    var body: some View {
        VStack {
            HeaderView(title: "Register",
                       subtitle: "",
                       angle: -15,
                       background: Color("tameYellow"))
            
            Form {
                TextField("Full name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                TextField("Email Address", text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                ButtonView(title: "Register",
                           background: .blue) {
                    viewModel.register()
                }
            }
            .offset(y: -50)
            
            Spacer()
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
