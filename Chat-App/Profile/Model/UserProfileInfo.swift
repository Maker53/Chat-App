//
//  UserProfileInfo.swift
//  Chat-App
//
//  Created by Станислав on 22.03.2022.
//

import Foundation

struct UserProfileInfo: Codable {
    
    var name = ""
    var description = ""
    var imageData: Data? = nil
}
