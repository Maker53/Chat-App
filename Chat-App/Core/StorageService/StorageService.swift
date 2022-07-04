//
//  StorageService.swift
//  Chat-App
//
//  Created by Станислав on 03.07.2022.
//

protocol StorageService {
    
    func fetchObject<T: Decodable>(withFileName fileName: String, type: T.Type) throws -> T?
    func saveObject<T: Encodable>(_ object: T, withFileName fileName: String) throws -> Bool
}
