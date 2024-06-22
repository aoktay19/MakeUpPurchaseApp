//
//  MakeUpProductDataSource.swift
//  MakeUpProductApp
//
//  Created by Ali Oktay on 7.01.2024.
//

import Foundation

struct MakeUpProductDataSource {

    private let baseURL = "https://makeup-api.herokuapp.com/api/v1/products.json"
    var delegate: MakeUpProductDataSourceDelegate?

    func loadMakeUpProductList(brand: String) {
        let session = URLSession.shared
        print("HERE")
        guard let url = URL(string: "\(baseURL)?brand=\(brand)") else { return }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let dataTask = session.dataTask(with: request) {
            data, response, error in
            guard let data  else { return }
            let decoder = JSONDecoder()
            do {
                let makeUpProductList = try decoder.decode([MakeUp].self, from: data)
                DispatchQueue.main.async {
                    delegate?.makeUpProductListLoaded(makeUpProductList: makeUpProductList)
                }
            } catch {
                print(error)
            }
        }
        dataTask.resume()
    }
}
