//
//  CartButton.swift
//  MakeUpProductApp
//
//  Created by Ali Oktay on 11.01.2024.
//

import SwiftUI

struct CartButton: View {
    var numberOfProducts: Int

    var body: some View {
        HStack{
            
            ZStack(alignment: .topTrailing) {

                Image(systemName: "cart")
                    .padding(.top, 5)

                if numberOfProducts > 0 {
                    Text("\(numberOfProducts)")
                        .font(.caption2).bold()
                        .foregroundColor(.white)
                        .frame(width: 15, height: 15)
                        .background(Color(hue: 1.0, saturation: 0.89, brightness: 0.835))
                        .cornerRadius(50)
                }

            }
            Text("Cart")
                .padding(.leastNonzeroMagnitude)

        }
    }
}

struct CartButton_Previews: PreviewProvider {
    static var previews: some View {
        CartButton(numberOfProducts: 1)
    }
}
