//
//  ShoppinCartModel.swift
//  MakeUpProductApp
//
//  Created by Ali Oktay on 11.01.2024.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth


class ShoppinCartModel: ObservableObject {
    @Published private(set) var makeUpProducts: Dictionary<MakeUp, Int> = [:]
    @Published private(set) var total: Double = 0.0
    let db = Firestore.firestore()
    let user: String

    
    init(userId: String) {
        self.user = userId
        self.fetchProductList(userId: userId)
    }

    func countTheElements() -> Int{
        makeUpProducts.values.reduce(0, { $0 + $1 })
    }

}

extension ShoppinCartModel: FirebaseDataManagerDelegate {
    func removeFromProductList(makeUp: MakeUp, userId: String) {
        if let number = makeUpProducts[makeUp] {
            makeUpProducts[makeUp] = number - 1
        }
        var i: Int = 0
        db.collection("User").document(userId).collection("Cart")
            .whereField("id", isEqualTo: makeUp.id)
            .getDocuments { (querySnapshot, error) in
                guard error == nil else{
                    print(error!.localizedDescription)
                    return
                }
                if let querySnapshot = querySnapshot {
                    for document in querySnapshot.documents {
                        // Delete the found document
                        if i < 1 {
                            document.reference.delete { error in
                                if let error = error {
                                    print("Error deleting document: \(error)")
                                } else {
                                    print("Document successfully deleted!")
                                }
                            }
                            i = 1
                        }

                    }
                }
            }
        total -= Double(makeUp.price ?? "0.0") ?? 0.0
    }
    
    func addToProductList(makeUp: MakeUp, userId: String, isInit: Bool) {
        let userDocRef = db.collection("User").document(userId).collection("Cart")
        if let number = makeUpProducts[makeUp] {
            makeUpProducts[makeUp] = number + 1
        }else{
            makeUpProducts[makeUp] = 1
        }
        if !isInit {
            do {
               try userDocRef.addDocument(from: makeUp)
            }
            catch {
                print(error)
            }
        }


        total += Double(makeUp.price ?? "0.0") ?? 0.0
    }
    
    func fetchProductList(userId: String) {
        let userDocRef = db.collection("User").document(userId).collection("Cart")

        userDocRef.getDocuments { snapshot, error in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }

            if let snapshot = snapshot {
                for document in snapshot.documents {
                    do {
                        let makeUp = try document.data(as: MakeUp.self)
                        self.addToProductList(makeUp: makeUp, userId: userId, isInit: true)

                    }
                    catch {
                      print(error)
                    }
                }
            }
        }
    }

}
