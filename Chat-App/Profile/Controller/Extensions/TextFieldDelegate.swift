//
//  TextFieldDelegate.swift
//  Chat-App
//
//  Created by Станислав on 06.03.2022.
//

import UIKit

extension ProfileViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let fullName = mainView?.userNameTextField.text else { return }
        guard let mainView = mainView else { return }

        let stringInput = fullName.components(separatedBy: " ").prefix(2)
        var fullNameInitials = ""

        for string in stringInput {
            fullNameInitials += String(string.first ?? " ")
        }
        
        if mainView.userImageView.image == nil {
            mainView.initialsLabel.text = fullNameInitials
        }
        
        if isDataChange() {
            setUIWithEditState(.hasChange)
        } else {
            setUIWithEditState(.hasNotChange)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mainView?.descriptionTextView.becomeFirstResponder()
        return true
    }
}
