//
//  DataManager.swift
//  Chat-App
//
//  Created by Станислав on 22.03.2022.
//

import Foundation
import UIKit

class StorageManager {
    
    static let shared = StorageManager()
    
    private init() {}
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func save(_ object: UserProfileInfo, with fileName: String) {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            let data = try JSONEncoder().encode(object)
            
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(atPath: url.path)
            }
            
            FileManager.default.createFile(atPath: url.path, contents: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchObject(from fileName: String) -> UserProfileInfo? {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        
        if let data = FileManager.default.contents(atPath: url.path) {
            do {
                let model = try JSONDecoder().decode(UserProfileInfo.self, from: data)
                return model
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("No data at path \(url.path)")
        }
        return nil
    }
}
