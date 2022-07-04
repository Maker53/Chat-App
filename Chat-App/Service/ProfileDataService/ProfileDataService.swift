//
//  ProfileDataService.swift
//  Chat-App
//
//  Created by Станислав on 03.07.2022.
//

protocol ProfileDataService {
    
    func fetchProfileFromFile() -> UserProfileInfo
    func saveProfileToFile(_ object: UserProfileInfo) -> Bool
}
