//
//  FirebaseServiceImplementation.swift
//  Chat-App
//
//  Created by Станислав on 03.07.2022.
//

import FirebaseFirestore

class FirebaseServiceImplementation: FirebaseService {
    
    var db = Firestore.firestore()
    var collectionReference: CollectionReference?
    
    func addSnapshotListener(block: @escaping (Result<[DocumentChange], Error>) -> Void) {
        guard let collectionReference = collectionReference else { return }
        
        collectionReference.addSnapshotListener { snapshot, error in
            if let error = error {
                block(.failure(error))
                return
            }
            
            if let document = snapshot?.documentChanges {
                block(.success(document))
            }
        }
    }
    
    func addDocument(data: [String: Any], completion: @escaping (Error?) -> Void) {
        guard let collectionReference = collectionReference else { return }
        
        collectionReference.addDocument(data: data) { error in
            completion(error)
        }
    }
    
    func deleteDocument(identifier: String, completion: @escaping (Error?) -> Void) {
        guard let collectionReference = collectionReference else { return }
        
        collectionReference.document(identifier).delete { error in
            completion(error)
        }
    }
    
    func updateDocument(identifier: String, data: [String: Any], completion: @escaping (Error?) -> Void) {
        guard let collectionReference = collectionReference else { return }
        
        collectionReference.document(identifier).updateData(data) { error in
            completion(error)
        }
    }
}
