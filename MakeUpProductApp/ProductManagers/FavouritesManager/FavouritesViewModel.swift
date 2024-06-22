//
//  FovouritesViewModel.swift
//  MakeUpProductApp
//
//  Created by Ali Oktay on 8.01.2024.
//

import Foundation
import FirebaseFirestore

class FavouritesViewModel: ObservableObject {
    @Published private(set) var makeUpProductList: [MakeUp] = []
    let db = Firestore.firestore()
    let user: String

    init(userId: String) {
        self.user = userId
        self.fetchProductList(userId: userId)
    }

    func isFavourite(makeUp: MakeUp) -> Bool {
        makeUpProductList.contains { $0.id == makeUp.id }
    }

}

extension FavouritesViewModel: FirebaseDataManagerDelegate {
    func removeFromProductList(makeUp: MakeUp, userId: String) {
        makeUpProductList = makeUpProductList.filter { $0.id != makeUp.id }

        db.collection("User").document(userId).collection("Favourites")
            .whereField("id", isEqualTo: makeUp.id)
            .getDocuments { (querySnapshot, error) in
                guard error == nil else{
                    print(error!.localizedDescription)
                    return
                }
                if let querySnapshot = querySnapshot {
                    for document in querySnapshot.documents {
                        // Delete the found document
                        document.reference.delete { error in
                            if let error = error {
                                print("Error deleting document: \(error)")
                            } else {
                                print("Document successfully deleted!")
                            }
                        }
                    }
                }
            }
    }
    
    func addToProductList(makeUp: MakeUp, userId: String, isInit: Bool) {
        let userDocRef = db.collection("User").document(userId).collection("Favourites")
        if !makeUpProductList.contains(where: { $0.id == makeUp.id}) {
            makeUpProductList.append(makeUp)
        }
        if !isInit {
            do {
                try userDocRef.addDocument(from: makeUp)
            }
            catch {
                print(error)
            }
        }
    }
    
    func fetchProductList(userId: String) {
        let userDocRef = db.collection("User").document(userId).collection("Favourites")

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

