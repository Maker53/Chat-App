//
//  ProfileViewController+ProfileViewDelegate.swift
//  Chat-App
//
//  Created by Станислав on 09.06.2022.
//

import UIKit

extension ProfileViewController: ProfileViewDelegate {
    
    // MARK: - Public Methods
    
    func editImageButtonAction() {
        presentChooseImageAlertController()
    }
    
    func editButtonAction() {
        setUIWithEditState(.willEditing)
    }
    
    func saveGCDButtonAction() {
        mainView?.activityIndicator.startAnimating()
        updateProfileData()
        currentMultithreadingService = gcdService
        saveData()
    }
    
    func saveOperationButtonAction() {
        mainView?.activityIndicator.startAnimating()
        updateProfileData()
        currentMultithreadingService = operationService
        saveData()
    }
    
    func cancelButtonAction() {
        setUIWithEditState(.cancelled)
    }
    
    // MARK: - Private Methods
    
    private func updateProfileData() {
        userProfileInfo = UserProfileInfo(
            name: mainView?.userNameTextField.text,
            description: mainView?.descriptionTextView.text,
            imageData: mainView?.userImageView.image?.pngData())
    }
}
