//
//  UserProfileView.swift
//  MakeUpProductApp
//
//  Created by Ali Oktay on 17.01.2024.
//

import SwiftUI
import Firebase

struct UserProfileView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.dismiss) var dismiss
    @State var presentingConfirmationDialog = false

    var body: some View {
        Form {
            Section {
                VStack {
                    HStack {

                        Spacer()

                        Image(systemName: "person.fill")
                          .resizable()
                          .frame(width: 100 , height: 100)
                          .aspectRatio(contentMode: .fit)
                          .clipShape(Circle())
                          .clipped()
                          .padding(4)
                          .overlay(Circle().stroke(Color.accentColor, lineWidth: 2))

                        Spacer()
                        }
                        Button(action: {}) {
                        Text("edit")
                    }
                }
            }

            emailDisplayView

            signOutButtonView

            deleteButtonView

        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .confirmationDialog("Deleting your account is permanent. Do you want to delete your account?",
                        isPresented: $presentingConfirmationDialog, titleVisibility: .visible) {
            Button("Delete Account", role: .destructive) {
                viewModel.deleteAccount()
            }
            Button("Cancel", role: .cancel, action: { })
        }
    }

    private var emailDisplayView: some View {
        Section("Email") {
          Text(viewModel.displayName)
        }
    }

    private var signOutButtonView: some View {
        Section {
            Button(role: .cancel){
                withAnimation{
                    viewModel.signOut()
                }
            } label: {
                HStack {
                    Spacer()
                    Text("Sign out")
                    Spacer()
                }
            }
        }
    }

    private var deleteButtonView: some View {
        Section {
            Button(role: .destructive, action: { presentingConfirmationDialog.toggle() }) {
                HStack {
                    Spacer()
                    Text("Delete Account")
                    Spacer()
                }
            }
        }

    }
}

struct UserProfileView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      UserProfileView()
        .environmentObject(AuthenticationViewModel())
    }
  }
}
