//
//  MakeUpInfoView.swift
//  MakeUpProductApp
//
//  Created by Ali Oktay on 8.01.2024.
//

import SwiftUI

struct MakeUpInfoView: View {
    let makeUp : MakeUp
    var isAddedFavourite: Bool
    var user: String
    private var makeUpInfoModel: MakeUpInfoModel
    @EnvironmentObject var shoppingCartModel: ShoppinCartModel
    @EnvironmentObject var favouritesViewModel : FavouritesViewModel



    init(makeUp: MakeUp, isAddedFavourite: Bool, user: String) {
        self.makeUp = makeUp
        self.isAddedFavourite = isAddedFavourite
        self.user = user
        self.makeUpInfoModel = MakeUpInfoModel(isTapped: self.isAddedFavourite)
    }

    var body: some View {
        VStack(spacing: 20) {
            MakeUpImageView(imageName: makeUp.image_link ?? "")
                .frame(maxWidth: .infinity, maxHeight: 250)
                .padding()
                .background(Color.white)
            
            detailView
        }
        .navigationTitle("Make Up Information")

        Spacer()

        HStack {
            Spacer()

            addFavourites

            Spacer()

            addToCart

            Spacer()
        }
    }

    private var detailView: some View {
        VStack(alignment: .leading) {
            Text(makeUp.name ?? "Make Up")
                .font(.title2)
                .padding(Spacing.padding_2)
                .layoutPriority(3)

            Text(makeUp.description ?? "It is a good product")
                .font(.callout)
                .padding(Spacing.padding_2)
                .layoutPriority(2)

            HStack {
                Text("Rating: \(makeUp.rating ?? 0.0, specifier: "%.2f")")
                    .padding(Spacing.padding_2)

                Spacer()

                Text(makeUp.category ?? "Category")
                    .foregroundColor(.white)
                    .padding(Spacing.padding_1)
                    .background(Capsule().fill(Color.indigo))
                    .padding(Spacing.padding_3)
            }

            Text("$\(Double(makeUp.price ?? "0.0") ?? 0.0, specifier: "%.2f")")
                .bold()
                .foregroundColor(.green)
                .padding(Spacing.padding_2)
        }
    }

    private var addFavourites: some View {
        Button(action: {
            if !makeUpInfoModel.isTapped{
                favouritesViewModel.addToProductList(makeUp: makeUp, userId: user, isInit: false)
                makeUpInfoModel.favouriteButtonTapped()
            }else {
                favouritesViewModel.removeFromProductList(makeUp: makeUp, userId: user)
                makeUpInfoModel.favouriteButtonUntapped()
            }
        }) {
            FavoriteButton(isTapped: makeUpInfoModel.isTapped)
        }
    }

    private var addToCart: some View {
        Button{
            shoppingCartModel.addToProductList(makeUp: makeUp, userId: user, isInit: false)
        } label: {
            CartButton(numberOfProducts: shoppingCartModel.countTheElements())
        }

    }
}

struct MakeUpInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MakeUpInfoView(makeUp: MakeUp(id: 0, brand: "", name: "", price: "", image_link: "", description: "", rating: 0.0, category: "", product_type: ""), isAddedFavourite: false, user: "")
            .environmentObject(FavouritesViewModel(userId: ""))
            .environmentObject(ShoppinCartModel(userId: ""))
    }
}
