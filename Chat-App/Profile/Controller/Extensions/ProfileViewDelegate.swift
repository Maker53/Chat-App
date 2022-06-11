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
    
    func cancelButtonAction() {
        
    }
}
