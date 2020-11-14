//
//  RegisterView.swift
//  MoviePreview
//
//  Created by Vinh Nguyen Dinh on R 2/11/09.
//

import SwiftUI

struct RegisterView: View {
    // MARK: - Properties
    @State private var emailString: String = ""
    @State private var passwordString: String = ""
    @State private var confirmPasswordString: String = ""
    @State private var registerSelection: Int? = nil
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
        }).onTapGesture {
            self.hideKeyboard()
        }
    }
    
    private func inputFormView() -> some View {
        return VStack(alignment: .leading, spacing: 0, content: {
            TextField("Email", text: $emailString)
                .modifier(TextFieldInputModifier())
            Spacer().frame(height: 20)
            TextField("Password", text: $passwordString)
                .modifier(TextFieldInputModifier())
            Spacer().frame(height: 20)
            TextField("Confirm Password", text: $confirmPasswordString)
                .modifier(TextFieldInputModifier())
        }).padding(10)
    }
    
    private func loginButton() -> some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Back to Login").loginModifier()
        })
    }
    
    private func registerButton() -> some View {
        NavigationLink(
            destination: destinationViewRegister(),
            tag: 1,
            selection: $registerSelection,
            label: {
                Button(action: {
                    registerSelection = 1
                }, label: {
                    Text("Sign up").loginModifier()
                })
            })
    }
    
    private func destinationViewRegister() -> some View {
        return HomeView()
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
    
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
    
    private func backgroundImageView() -> some View {
        return Image("background")
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
