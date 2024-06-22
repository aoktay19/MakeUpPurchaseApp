//
//  MakeUpProductAppApp.swift
//  MakeUpProductApp
//
//  Created by Ali Oktay on 7.01.2024.
//

import SwiftUI
import Firebase

class YourSimpleAppCheckProviderFactory: NSObject, AppCheckProviderFactory {
  func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
    return AppAttestProvider(app: app)
  }
}

@main
struct MakeUpProductAppApp: App {

    init(){
        let providerFactory = YourSimpleAppCheckProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
