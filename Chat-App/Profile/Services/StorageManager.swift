//
//  DataManager.swift
//  Chat-App
//
//  Created by Станислав on 22.03.2022.
//

import UIKit

class StorageManager {
    // MARK: - Singleton
    static let shared = StorageManager()
    
    // MARK: - Private empty init
    private init() {}
    
    // MARK: - Save object
    func save(_ object: UserProfileInfo, with fileName: String) {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            let data = try JSONEncoder().encode(object)
            
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(atPath: url.path)
            }
            
            FileManager.default.createFile(atPath: url.path, contents: data)
        } catch {
            // TODO: Либо убрать, либо сообщить пользователю о неудаче
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Fetch object
    func fetchObject(from fileName: String) -> UserProfileInfo? {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        
        if let data = FileManager.default.contents(atPath: url.path) {
            do {
                let model = try JSONDecoder().decode(UserProfileInfo.self, from: data)
                return model
            } catch {
                // TODO: Либо убрать, либо сообщить пользователю о неудаче
                print(error.localizedDescription)
            }
        } else {
            // TODO: Либо убрать, либо сообщить пользователю о неудаче
            print("No data at path \(url.path)")
        }
        return nil
    }
    
    // MARK: - Get Documents Directory
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
