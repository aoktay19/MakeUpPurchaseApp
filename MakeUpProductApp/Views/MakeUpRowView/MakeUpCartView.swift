//
//  MakeUpCartView.swift
//  MakeUpProductApp
//
//  Created by Ali Oktay on 15.01.2024.
//

import SwiftUI

struct MakeUpCartView: View {
    @EnvironmentObject var shoppingCartModel : ShoppinCartModel
    @EnvironmentObject var favouritesViewModel : FavouritesViewModel
    var makeUp: MakeUp
    var isCart: Bool
    var numberOfProducts: Int
    var isAddedFavourite: Bool
    var user: String

    var body: some View {
        HStack(spacing: 20) {
            NavigationLink(
                destination: MakeUpInfoView(makeUp: makeUp, isAddedFavourite: isAddedFavourite, user: user)
                    .environmentObject(shoppingCartModel)
                    .environmentObject(favouritesViewModel)
            ){
                MakeUpImageView(imageName: makeUp.image_link ?? "")
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .cornerRadius(10)

                VStack(alignment: .leading, spacing: 10) {
                    Text(makeUp.name ?? "Name")
                        .bold()
                    
                    Text("$\(makeUp.price ?? "0.0")")
                }

                Spacer()

                Image(systemName: "trash")
                    .foregroundColor(Color(hue: 1.0, saturation: 0.89, brightness: 0.835))
                    .onTapGesture {
                        if isCart {
                            shoppingCartModel.removeFromProductList(makeUp: makeUp, userId: user)
                        }else {
                            favouritesViewModel.removeFromProductList(makeUp: makeUp, userId: user)
                        }
                    }
                if numberOfProducts > 0 {
                    Text("\(numberOfProducts)")
                        .font(.caption2).bold()
                        .foregroundColor(.white)
                        .frame(width: 15, height: 15)
                        .background(Color(hue: 1.0, saturation: 0.89, brightness: 0.835))
                        .cornerRadius(50)
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct MakeUpCartView_Previews: PreviewProvider {
    static var previews: some View {
        MakeUpCartView(makeUp: MakeUp(id: 0, brand: "", name: "", price: "", image_link: "", description: "", rating: 0.0, category: "", product_type: ""), isCart: false, numberOfProducts: 0, isAddedFavourite: false, user: "")
            .environmentObject(FavouritesViewModel(userId: ""))
            .environmentObject(ShoppinCartModel(userId: ""))
    }
}
