//
//  DataManager.swift
//  Chat-App
//
//  Created by Станислав on 22.03.2022.
//

import Foundation

class StorageManager {
    // MARK: - Singleton
    static let shared = StorageManager()
    
    // MARK: - Private Serial Queue
    let privateSerialQueue = DispatchQueue(label: "storageManagerQueue", qos: .utility)
    
    // MARK: - Private empty init
    private init() {}
    
    // MARK: - Save object
    func saveViaGCD(with object: UserProfileInfo, and fileName: String, notifyHandler completion: @escaping () -> ()) {
        let workItem = DispatchWorkItem {
            self.save(object, with: fileName)
        }
        
        privateSerialQueue.async(execute: workItem)
        
        workItem.notify(queue: .main) {
            completion()
        }
    }
    
    // MARK: - Fetch object
    func fetchViaGCD(from fileName: String, completion: @escaping (UserProfileInfo?) -> ()) {
        privateSerialQueue.async {
            let object = self.fetchObject(from: fileName)
            completion(object)
        }
    }
    
    // MARK: - Get Documents Directory
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // TODO: Подумать, как можно проверять объект, чтобы не перезаписывать повторяющиеся данные
    private func save(_ object: UserProfileInfo, with fileName: String) {
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
    
    private func fetchObject(from fileName: String) -> UserProfileInfo? {
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
}
