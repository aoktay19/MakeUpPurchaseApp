//
//  LoginView.swift
//  MakeUpProductApp
//
//  Created by Ali Oktay on 16.01.2024.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.dismiss) var dismiss

    @FocusState private var focus: Bool

    var body: some View {
    NavigationStack {
        VStack{
            Text("Login")
              .font(.largeTitle)
              .fontWeight(.bold)
              .frame(maxWidth: .infinity, alignment: .leading)

            emailTextFieldView

            passwordTextFieldView

            if !viewModel.errorMessage.isEmpty {
              VStack {
                Text(viewModel.errorMessage)
                  .foregroundColor(Color(UIColor.systemRed))
              }
            }

            loginButtonView

            signInSuggestionView
            }
            .listStyle(.plain)
            .padding()
            .onTapGesture {
              dismiss()
          }
      }
    }

    private var emailTextFieldView: some View {
        HStack {
          Image(systemName: "at")
          TextField("Email", text: $viewModel.email)
            .textInputAutocapitalization(.never)
            .focused($focus)
            .submitLabel(.next)
        }
        .padding(.vertical, 6)
        .background(Divider(), alignment: .bottom)
        .padding(.bottom, 4)
    }

    private var passwordTextFieldView: some View {
        HStack {
          Image(systemName: "lock")
          SecureField("Password", text: $viewModel.password)
            .focused($focus)
            .submitLabel(.go)
        }
        .padding(.vertical, 6)
        .background(Divider(), alignment: .bottom)
        .padding(.bottom, 8)
    }

    private var loginButtonView: some View {
        Button(action: login) {
          if !viewModel.isAuthenticated {
            Text("Login")
              .padding(.vertical, 8)
              .frame(maxWidth: .infinity)
          }
          else {
                ProgressView()
                  .progressViewStyle(CircularProgressViewStyle(tint: .white))
                  .padding(.vertical, 8)
                  .frame(maxWidth: .infinity)
          }
        }
        .frame(maxWidth: .infinity)
        .buttonStyle(.borderedProminent)
    }

    private var signInSuggestionView: some View {
        HStack {
            Text("Don't have an account yet?")

            NavigationLink(destination: SignUpView()
              .environmentObject(viewModel)) {
            Text("Sign up")
              .fontWeight(.semibold)
              .foregroundColor(.blue)
            }
        }
        .padding([.top, .bottom], 50)
    }

    func login() {
        Task{
            if await viewModel.signInWithEmailPassword() == true{
                dismiss()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      LoginView()
      LoginView()
        .preferredColorScheme(.dark)
    }
    .environmentObject(AuthenticationViewModel())
  }
}
