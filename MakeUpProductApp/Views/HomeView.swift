//
//  HomeView.swift
//  MakeUpProductApp
//
//  Created by Ali Oktay on 8.01.2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @EnvironmentObject var shoppingCartModel: ShoppinCartModel
    @EnvironmentObject var favouritesViewModel: FavouritesViewModel

    @State private var selectedTab: Tab = .profile

    enum Tab {
        case profile, search, favourites, shoppingCart
    }

    var body: some View {
        NavigationStack{

            TabView(selection: $selectedTab) {
                UserProfileView()
                    .environmentObject(authenticationViewModel)
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
                    .tag(Tab.profile)
                    .tableColumnHeaders(.automatic)

                SearchView()
                    .environmentObject(shoppingCartModel)
                    .environmentObject(favouritesViewModel)
                    .tabItem {
                        Label("Search ", systemImage: "magnifyingglass")
                    }
                    .tag(Tab.search)
                    .tableColumnHeaders(.automatic)

                FavouritesView()
                    .environmentObject(shoppingCartModel)
                    .environmentObject(favouritesViewModel)
                    .environmentObject(authenticationViewModel)
                    .tabItem {
                        Label("Favourites", systemImage: "heart")
                    }
                    .tag(Tab.favourites)
                    .tableColumnHeaders(.automatic)

                ShoppingCartView()
                    .environmentObject(shoppingCartModel)
                    .environmentObject(favouritesViewModel)
                    .environmentObject(authenticationViewModel)
                    .tabItem {
                        CartButton(numberOfProducts: shoppingCartModel.countTheElements())
                    }
                    .tag(Tab.shoppingCart)
                    .tableColumnHeaders(.automatic)
            }
            .navigationTitle(tabTitle())
        }
    }

    func tabTitle() -> String {
        switch selectedTab {
        case .profile: return "Profile"
        case .search: return "Search"
        case .favourites: return "Favourites"
        case .shoppingCart: return "Shopping Cart"
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AuthenticationViewModel())
            .environmentObject(ShoppinCartModel(userId: ""))
            .environmentObject(FavouritesViewModel(userId: ""))

    }
}
