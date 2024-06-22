//
//  ShoppingCartView.swift
//  MakeUpProductApp
//
//  Created by Ali Oktay on 11.01.2024.
//

import SwiftUI

struct ShoppingCartView: View {
    @EnvironmentObject var shoppingCartModel : ShoppinCartModel
    @EnvironmentObject var favouritesViewModel : FavouritesViewModel
    @EnvironmentObject var authenticationViewModel : AuthenticationViewModel

    var body: some View {
        ScrollView{
            VStack{
                if shoppingCartModel.countTheElements() > 0 {
                    ForEach(shoppingCartModel.makeUpProducts.keys.sorted(by: { $0.id < $1.id }), id: \.id) { makeUp in
                        if let number = shoppingCartModel.makeUpProducts[makeUp] {
                            if number != 0 {
                                MakeUpCartView(makeUp: makeUp, isCart: true, numberOfProducts: number,isAddedFavourite: favouritesViewModel.isFavourite(makeUp: makeUp), user: authenticationViewModel.displayName)
                                    .environmentObject(shoppingCartModel)
                                    .environmentObject(favouritesViewModel)
                            }
                        }
                    }

                    HStack {
                        Text("Your cart total is")
                        Spacer()
                        Text("$\(shoppingCartModel.total, specifier: "%.2f")")
                            .bold()
                    }
                    .padding()

                } else {
                    Text("Your cart is empty.")
                }
            }
            .navigationTitle("MY CART")
            .padding(.top)
        }

    }
}

struct ShoppingCartView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCartView().environmentObject(ShoppinCartModel(userId: ""))
    }
}
