//
//  ProfileDataServiceImplementation.swift
//  Chat-App
//
//  Created by Станислав on 03.07.2022.
//

class ProfileDataServiceImplementation: ProfileDataService {
    
    private let storageService = CoreAssembly.storageService
    
    func fetchProfileFromFile() -> UserProfileInfo {
        let user = try? storageService.fetchObject(withFileName: Constants.userProfileFileName, type: UserProfileInfo.self)
        
        return UserProfileInfo(name: user?.name, description: user?.description, imageData: user?.imageData)
    }
    
    func saveProfileToFile(_ object: UserProfileInfo) -> Bool {
        let prevUser = fetchProfileFromFile()
        var isSaved = false
        
        do {
            if prevUser.name != object.name {
                isSaved = try storageService.saveObject(object, withFileName: Constants.userProfileFileName)
            }
            
            if prevUser.description != object.description {
                isSaved = try storageService.saveObject(object, withFileName: Constants.userProfileFileName)
            }
            
            if prevUser.imageData != object.imageData {
                isSaved = try storageService.saveObject(object, withFileName: Constants.userProfileFileName)
            }
        } catch {
            isSaved = false
        }
        
        return isSaved
    }
}
