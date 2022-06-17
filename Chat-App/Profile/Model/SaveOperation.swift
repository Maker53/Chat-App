//
//  SaveOperation.swift
//  Chat-App
//
//  Created by Станислав on 16.06.2022.
//

import Foundation

class SaveUserInfoOperation: Operation {
    private var object: UserProfileInfo
    var isSaved = false
    
    init(object: UserProfileInfo) {
        self.object = object
        super.init()
    }
    
    override func main() {
        isSaved = StorageManager.saveObjectToFile(object)
    }
}
