//
//  SearchViewModel.swift
//  MakeUpProductApp
//
//  Created by Ali Oktay on 8.01.2024.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var makeUpProductList: [MakeUp] = []


    private var dataSource = MakeUpProductDataSource()

    init() {
        dataSource.delegate = self

    }

    func searchAction(brand: String) -> Void {
        dataSource.loadMakeUpProductList(brand: brand)
    }


}

extension SearchViewModel: MakeUpProductDataSourceDelegate {
    func makeUpProductListLoaded(makeUpProductList: [MakeUp]) {
        isLoading = false
        self.makeUpProductList = makeUpProductList
    }

}
