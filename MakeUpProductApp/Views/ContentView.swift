//
//  ContentView.swift
//  MakeUpProductApp
//
//  Created by Ali Oktay on 16.01.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    var body: some View {
        AuthenticationView()
            .environmentObject(authenticationViewModel)
    }
}

#Preview {
    ContentView()
}
