//
//  LoginView.swift
//  MoviePreview
//
//  Created by Vinh Nguyen Dinh on R 2/11/06.
//

import SwiftUI
import ActivityIndicatorView

struct LoginView: View {
    // MARK: - Properties
    @ObservedObject var viewModel = LoginViewModel()
    
    // MARK: - Body
    var body: some View {
        contentView()
    }
    
    // MARK: - Content views
    private func contentView() -> some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
            backgroundImageView()
            VStack {
                logoView()
                Spacer().frame(height: 100)
                inputFormView()
                Spacer().frame(height: 40)
                loginButton()
                Spacer().frame(height: 20)
                registerButton()
            }
            ActivityIndicatorView(isVisible: self.$viewModel.isLoading, type: .flickeringDots)
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.white)
        }).onTapGesture {
            self.hideKeyboard()
        }
    }
    
    // Input form email and password
    private func inputFormView() -> some View {
        return VStack(alignment: .leading, spacing: 0, content: {
            TextField("Email", text: self.$viewModel.username)
                .modifier(TextFieldInputModifier())
            Spacer().frame(height: 20)
            SecureField("Password", text: self.$viewModel.password)
                .modifier(TextFieldInputModifier())
        }).padding(10)
    }
    
    // Login button
    private func loginButton() -> some View {
        NavigationLink(
            destination: destinationViewLogin(),
            isActive: .constant(self.$viewModel.isLogedIn.wrappedValue),
            label: {
                Button(action: {
                    // Hide keyboard
                    self.hideKeyboard()
                    
                    // Create request token and login
                    self.viewModel.createRequestToken()
                }, label: {
                    Text("Login").loginModifier()
                }).disabled(self.$viewModel.isLoading.wrappedValue)
            })
    }
    
    // Home view
    private func destinationViewLogin() -> some View {
        return HomeView()
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
    
    // Register button
    private func registerButton() -> some View {
        NavigationLink(
            destination: destinationViewRegister(),
            isActive: .constant(self.$viewModel.isShowRegister.wrappedValue),
            label: {
                Button(action: {
                    // Show register screen
                    self.viewModel.isShowRegister = true
                }, label: {
                    Text("Register").loginModifier()
                }).disabled(self.$viewModel.isLoading.wrappedValue)
            })
    }
    
    // Register view
    private func destinationViewRegister() -> some View {
        return RegisterView()
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
    
    // Logo view
    private func logoView() -> some View {
        return VStack {
            Image("logo")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
            Text("Movie Preview")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.headline)
                .textCase(.uppercase)
        }
    }
    
    // Background image view
    private func backgroundImageView() -> some View {
        return Image("background")
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
