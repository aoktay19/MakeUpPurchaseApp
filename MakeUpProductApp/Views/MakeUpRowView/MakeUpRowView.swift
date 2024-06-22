//
//  MakeUpRowView.swift
//  MakeUpProductApp
//
//  Created by Ali Oktay on 8.01.2024.
//

import SwiftUI

struct MakeUpRowView: View {

    var makeUp: MakeUp
    @EnvironmentObject var shoppingCartModel : ShoppinCartModel
    @EnvironmentObject var favouritesViewModel : FavouritesViewModel
    var isAddedFavourite : Bool

    var body: some View {
        HStack {
            NavigationLink(
                destination: MakeUpInfoView(makeUp: makeUp, isAddedFavourite: isAddedFavourite, user: shoppingCartModel.user)
                    .environmentObject(shoppingCartModel)
                    .environmentObject(favouritesViewModel)
            ) {
                MakeUpImageView(imageName: makeUp.image_link ?? "")
                    .frame(width: 120, height: 120)

                VStack(alignment: .leading) {
                    Text(makeUp.brand ?? "Brand")
                        .font(.headline)
                        .padding(.bottom, 5)
                    Text("Price \(makeUp.price ?? "0.0")")
                        .font(.subheadline)
                        .foregroundColor(.green)
                    HStack {
                        Text("Rating: \(makeUp.rating ?? 0.0, specifier: "%.2f")")
                            .foregroundColor(.gray)
                    }

                    Text(makeUp.category ?? "category")
                        .foregroundColor(.white)
                        .padding(.horizontal, 13).padding(.vertical, 3)
                        .background(Capsule().fill(Color.indigo))
                }
            }
        }
    }

}

struct MakeUpRowView_Previews: PreviewProvider {
    static var previews: some View {
        MakeUpRowView(makeUp: MakeUp(id: 0, brand: "", name: "", price: "", image_link: "", description: "", rating: 0.0, category: "", product_type: ""), isAddedFavourite: false)
            .environmentObject(FavouritesViewModel(userId:""))
            .environmentObject(ShoppinCartModel(userId: ""))
    }
}

