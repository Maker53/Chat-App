//
//  Constants.swift
//  Chat-App
//
//  Created by Станислав on 14.05.2022.
//

import UIKit

enum Constants {
    
    static let myID = UIDevice.current.identifierForVendor?.uuidString
    static let userProfileFileName = "userProfile"
    static let channelsCollectionPath = "channels"
    static let messagesCollectionPath = "messages"
    static let persistentContainerName = "Conversations"
    static let messageIdentifier = "Firebase_generates"
    static let collectionViewCellIdentifier = "profileImagePickerCell"
    static let loadingReusableViewIdetifier = "reusableView"
    static let apiKeyForProfileImageList = "yUzsjr9tf1rStF9lN28I8l1MmppFneZVQccp6OqWgjU"
}
