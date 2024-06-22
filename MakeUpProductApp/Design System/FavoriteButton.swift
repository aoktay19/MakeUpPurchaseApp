//
//  FavoriteButton.swift
//  MakeUpProductApp
//
//  Created by Ali Oktay on 17.01.2024.
//

import SwiftUI

struct FavoriteButton: View {
    var isTapped: Bool

    var body: some View {
        HStack{

            if isTapped {
                Image(systemName: "heart.fill")
                    .padding(.top, 5)
            }else {
                Image(systemName: "heart")
                    .padding(.top, 5)
            }

            Text("Favourites")
                .padding(.leastNonzeroMagnitude)

        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isTapped: false)
    }
}
