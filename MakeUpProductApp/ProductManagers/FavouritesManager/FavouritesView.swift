//
//  FavuritesView.swift
//  MakeUpProductApp
//
//  Created by Ali Oktay on 8.01.2024.
//

import SwiftUI

struct FavouritesView: View {
    @EnvironmentObject var shoppingCartModel : ShoppinCartModel
    @EnvironmentObject var favouritesViewModel : FavouritesViewModel
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel


    var body: some View {
        ScrollView{
            VStack{
                if favouritesViewModel.makeUpProductList.count > 0 {
                    ForEach(favouritesViewModel.makeUpProductList, id: \.id) { makeUp in
                        MakeUpCartView(makeUp: makeUp, isCart: false, numberOfProducts: 0, isAddedFavourite:true, user: authenticationViewModel.displayName)
                            .environmentObject(shoppingCartModel)
                            .environmentObject(favouritesViewModel)
                    }
                } else {
                    Text("Your favourites is empty.")
                }
            }
            .navigationTitle("MY FAVOURITES")
            .padding(.top)
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView().environmentObject(FavouritesViewModel(userId: ""))
    }
}
