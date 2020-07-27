//
//  FirestoreManager.swift
//  LandmarkRemark
//
//  Created by Michael Yuwono on 26/7/20.
//  Copyright © 2020 Michael Yuwono. All rights reserved.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

class FirestoreManager: NSObject, ObservableObject {

    // Current active user
    @Published var user: User?
    
    // All loaded remarks
    @Published var remarks: [Remark] = [Remark]()
    
    // Listener to listen to remarks updates
    private var listenerRegistration: ListenerRegistration?
    
    // Firestore manager
    private let firestore: Firestore = Firestore.firestore()
    
    func listenForRemarks() {
        // Stop running listener
        if listenerRegistration != nil {
            listenerRegistration?.remove()
        }
        
        listenerRegistration = firestore
        .collection("remarks")
            .addSnapshotListener({ (snapshot, error) in
                if let snapshot = snapshot {
                    self.remarks = snapshot.documents.compactMap({ (document) in
                        try? document.data(as: Remark.self)
                    })
                }
            })
    }
    
    // Get user from the given user ID
    func getUser(id: String, completion: @escaping (_ user: User?) -> Void) {
        firestore
            .collection("users")
            .document(id)
            .getDocument { (snapshot, error) in
                var user: User? = nil
                if let snapshot = snapshot {
                    user = try? snapshot.data(as: User.self)
                }
                
                return completion(user)
            }
    }
    
    // Add a new user given a username, returning the full user document and request result
    func addUser(username: String, completion: ((_ user: User?, _ result: Bool) -> Void)? = nil) {
        var ref: DocumentReference? = nil
        ref = firestore
            .collection("users")
            .addDocument(data: ["username": username]) { (error) in
                var user: User? = nil
                var result: Bool = true
                
                if let error = error {
                    result = false
                    print(error)
                } else {
                    user = User(id: ref!.documentID, username: username)
                }
                
                if let completion = completion {
                    completion(user, result)
                }
            }
    }
    
    // Add a new remark given notes and coordinate, returning the request result
    func addRemark(notes: String, coordinate: GeoPoint, completion: ((_ result: Bool) -> Void)? = nil) {
        firestore
            .collection("remarks")
            .addDocument(data: [
                "notes": notes,
                "coordinate": coordinate,
                "userId": self.user!.id!]) { (error) in
                    var result = true
                    if let error = error {
                        result = false
                        print(error)
                    }
                    
                    if let completion = completion {
                        completion(result)
                    }
                }
    }
}
