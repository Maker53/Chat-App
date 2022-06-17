//
//  GCDManager.swift
//  Chat-App
//
//  Created by Станислав on 15.06.2022.
//

import Foundation

class GCDManager: MultithreadingManager {
    private let privateSerialQueue = DispatchQueue(label: "storageManagerQueue", qos: .userInitiated)
    
    func fetchData(completion: @escaping (UserProfileInfo) -> Void) {
        privateSerialQueue.async {
            let object = StorageManager.fetchObjectFromFile()
            
            DispatchQueue.main.async {
                completion(object)
            }
        }
    }
    
    func saveData(_ data: UserProfileInfo, completion: @escaping (Bool) -> Void) {
        var isSaved = false
        let workItem = DispatchWorkItem {
            
            isSaved = StorageManager.saveObjectToFile(data)
        }
        
        privateSerialQueue.async(execute: workItem)
        
        workItem.notify(queue: .main) {
            completion(isSaved)
        }
    }
}
