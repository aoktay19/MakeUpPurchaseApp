//
//  AuthenticationView.swift
//  MakeUpProductApp
//
//  Created by Ali Oktay on 15.01.2024.
//

import SwiftUI
import Firebase

struct AuthenticationView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel

    var body: some View {
        NavigationStack {
            if viewModel.isAuthenticated {
                HomeView()
                    .environmentObject(ShoppinCartModel(userId: viewModel.displayName))
                    .environmentObject(FavouritesViewModel(userId: viewModel.displayName))
                    .environmentObject(viewModel)
            }else {
                LoginView()
                    .environmentObject(viewModel)
            }
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
  static var previews: some View {
    AuthenticationView()
      .environmentObject(AuthenticationViewModel())
  }
}
