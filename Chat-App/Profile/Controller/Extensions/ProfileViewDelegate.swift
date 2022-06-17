//
//  ProfileViewDelegate.swift
//  Chat-App
//
//  Created by Станислав on 09.06.2022.
//

import Foundation

extension ProfileViewController: ProfileViewDelegate {
    func editImageButtonAction() {
        presentChooseImageAlertController()
    }
    
    func editButtonAction() {
        setUIWithEditState(.willEditing)
    }
    
    func saveGCDButtonAction() {
        mainView?.activityIndicator.startAnimating()
        dataManager = GCDManager()
        updateProfileData()
        saveData()
    }
    
    func saveOperationButtonAction() {
        mainView?.activityIndicator.startAnimating()
        dataManager = OperationsManager()
        updateProfileData()
        saveData()
    }
    
    func cancelButtonAction() {
        setUIWithEditState(.cancelled)
    }
    
    private func updateProfileData() {
        userProfileInfo = UserProfileInfo(
            name: mainView?.userNameTextField.text,
            description: mainView?.descriptionTextView.text,
            imageData: mainView?.userImageView.image?.pngData())
    }
}
