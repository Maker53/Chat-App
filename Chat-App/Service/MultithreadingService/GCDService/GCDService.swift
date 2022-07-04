//
//  GCDService.swift
//  Chat-App
//
//  Created by Станислав on 03.07.2022.
//

import Foundation

class GCDService: MultithreadingService {
    
    private let privateSerialQueue = DispatchQueue(label: "storageManagerQueue", qos: .userInitiated)
    private let profileDataService = ServiceAssembly.profileDataService
    
    func saveData(_ data: UserProfileInfo, completion: @escaping (Bool) -> Void) {
        var isSaved = false
        let workItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            
            isSaved = self.profileDataService.saveProfileToFile(data)
        }
        
        privateSerialQueue.async(execute: workItem)
        
        workItem.notify(queue: .main) {
            completion(isSaved)
        }
    }
    
    func fetchData(completion: @escaping (UserProfileInfo) -> Void) {
        privateSerialQueue.async { [weak self] in
            guard let self = self else { return }
            let object = self.profileDataService.fetchProfileFromFile()
            
            DispatchQueue.main.async {
                completion(object)
            }
        }
    }
}
