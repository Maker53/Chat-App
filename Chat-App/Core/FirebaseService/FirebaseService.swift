//
//  FirebaseService.swift
//  Chat-App
//
//  Created by Станислав on 03.07.2022.
//

import FirebaseFirestore

protocol FirebaseService {
    
    var db: Firestore { get }
    var collectionReference: CollectionReference? { get set }
    
    func addSnapshotListener(block: @escaping (Result<[DocumentChange], Error>) -> Void)
    func addDocument(data: [String: Any], completion: @escaping (Error?) -> Void)
    func deleteDocument(identifier: String, completion: @escaping (Error?) -> Void)
    func updateDocument(identifier: String, data: [String: Any], completion: @escaping (Error?) -> Void)
}
