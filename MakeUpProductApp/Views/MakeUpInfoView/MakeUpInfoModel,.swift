//
//  MakeUpInfoModel,.swift
//  MakeUpProductApp
//
//  Created by Ali Oktay on 17.01.2024.
//

import Foundation

class MakeUpInfoModel: ObservableObject {
    @Published var systemImageName: String
    @Published var isTapped: Bool

    init(isTapped: Bool) {
        self.isTapped = isTapped
        systemImageName = isTapped ? "heart.fill": "heart"
    }

    func favouriteButtonTapped() {
        isTapped.toggle()
        self.systemImageName = "heart.fill"
    }

    func favouriteButtonUntapped() {
        isTapped.toggle()
        self.systemImageName = "heart"
    }

    
}
