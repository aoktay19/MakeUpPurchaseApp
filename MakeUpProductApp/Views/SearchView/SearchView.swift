//
//  SearchView.swift
//  MakeUpProductApp
//
//  Created by Ali Oktay on 8.01.2024.
//

import SwiftUI

struct SearchView: View {

    @State private var searchText = ""
    @Environment(\.dismissSearch) var dismissSearch
    @EnvironmentObject var shoppingCartModel: ShoppinCartModel
    @EnvironmentObject var favouritesViewModel: FavouritesViewModel
    @StateObject private var viewModel = SearchViewModel()
    @FocusState private var isFirstResponder: Bool

    var body: some View {
        VStack {
            Spacer()
            searchView
        }
    }

    private var searchView : some View {
        NavigationView {
            if !viewModel.isLoading {
                List(viewModel.makeUpProductList, id: \.self) { makeUp in
                    MakeUpRowView(makeUp: makeUp, isAddedFavourite: favouritesViewModel.isFavourite(makeUp: makeUp))
                        .environmentObject(shoppingCartModel)
                        .environmentObject(favouritesViewModel)
                }
            } else {
                Text("Search For a Product Brand")
            }
        }
        .navigationTitle("Product Search")
        .searchable(text: $searchText)
        .focused($isFirstResponder)
        .onChange(of: searchText) {
            viewModel.isLoading = true
        }
        .onSubmit(of: .search) {
            viewModel.searchAction(brand: searchText)
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(FavouritesViewModel(userId: ""))
            .environmentObject(ShoppinCartModel(userId: ""))
    }
}
