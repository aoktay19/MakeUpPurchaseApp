//
//  SignUpView.swift
//  MakeUpProductApp
//
//  Created by Ali Oktay on 16.01.2024.
//

import SwiftUI
import Firebase

struct SignUpView: View {
  @EnvironmentObject var viewModel: AuthenticationViewModel
  @Environment(\.dismiss) var dismiss
  @FocusState private var focus: Bool

    var body: some View {
        VStack {
            Text("Sign up")
            .font(.largeTitle)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)

            emailTextFieldView

            passwordTextFieldView

            confirmationPasswordView

            if !viewModel.errorMessage.isEmpty {
                VStack {
                  Text(viewModel.errorMessage)
                    .foregroundColor(Color(UIColor.systemRed))
                }
            }

            signUpButtonView
        }
        .listStyle(.plain)
        .padding()
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
            .submitLabel(.next)
        }
        .padding(.vertical, 6)
        .background(Divider(), alignment: .bottom)
        .padding(.bottom, 8)
    }

    private var confirmationPasswordView: some View {
        HStack {
          Image(systemName: "lock")
          SecureField("Confirm password", text: $viewModel.confirmPassword)
            .focused($focus)
            .submitLabel(.go)
        }
        .padding(.vertical, 6)
        .background(Divider(), alignment: .bottom)
        .padding(.bottom, 8)
    }

    private var signUpButtonView: some View {
        Button(action: signUp){
          Text("Sign up")
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .buttonStyle(.borderedProminent)
    }

    func signUp() {
        Task{
            if await viewModel.signUpWithEmailPassword() == true{
                dismiss()
            }
        }
    }

}

struct SignUpView_Previews: PreviewProvider {
  static var previews: some View {
      SignUpView()
          .environmentObject(AuthenticationViewModel())
  }
}
