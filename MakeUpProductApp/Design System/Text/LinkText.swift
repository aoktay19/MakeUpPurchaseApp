//
//  LinkText.swift
//  MakeUpProductApp
//
//  Created by Ali Oktay on 7.01.2024.
//

import SwiftUI

struct LinkText: View {

    private let text: String

    init(text: String) {
        self.text = text
    }
    var body: some View {
        Text(text)
            .foregroundStyle(.linkText)
    }
}

#Preview {
    LinkText(text: "Test")
}
