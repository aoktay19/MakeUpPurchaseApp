//
//  MakeUpImageView.swift
//  MakeUpProductApp
//
//  Created by Ali Oktay on 8.01.2024.
//

import SwiftUI

struct MakeUpImageView: View {
    private let imageName: String

    init(imageName: String) {
        self.imageName = imageName
    }

    var body: some View {
        VStack(spacing: Spacing.padding_2) {

            AsyncImage(url: URL(string: imageName)){ image in
                image
                    .image?.resizable()
                    .scaledToFit()
            }
            .padding(Spacing.padding_2)

        }
    }
}

#Preview {
    MakeUpImageView(imageName: "back")
}
