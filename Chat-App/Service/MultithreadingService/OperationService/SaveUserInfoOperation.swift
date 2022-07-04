//
//  SaveUserInfoOperation.swift
//  Chat-App
//
//  Created by Станислав on 16.06.2022.
//

import Foundation

class SaveUserInfoOperation: Operation {
    
    var isSaved = false
    
    private let profileDataService = ServiceAssembly.profileDataService
    private var object: UserProfileInfo
    
    init(object: UserProfileInfo) {
        self.object = object
        super.init()
    }
    
    override func main() {
        isSaved = profileDataService.saveProfileToFile(object)
    }
}
