//
//  DataManager.swift
//  Chat-App
//
//  Created by Станислав on 22.03.2022.
//

import Foundation

class StorageManager {
    static func fetchObjectFromFile() -> UserProfileInfo {
        let user = try? JSONSerialization.fetchObject(withFileName: Constants.userProfileFileName, type: UserProfileInfo.self)
        let name = user?.name
        let description = user?.description
        let imageData = user?.imageData
        
        return UserProfileInfo(name: name, description: description, imageData: imageData)
    }
    
    static func saveObjectToFile(_ object: UserProfileInfo) -> Bool {
        let prevUser = fetchObjectFromFile()
        var isSaved = false
        
        do {
            if prevUser.name != object.name {
                isSaved = try JSONSerialization.saveObject(object, withFileName: Constants.userProfileFileName)
            }
            
            if prevUser.description != object.description {
                isSaved = try JSONSerialization.saveObject(object, withFileName: Constants.userProfileFileName)
            }
            
            if prevUser.imageData != object.imageData {
                isSaved = try JSONSerialization.saveObject(object, withFileName: Constants.userProfileFileName)
            }
        } catch {
            isSaved = false
        }
        
        return isSaved
    }
}
