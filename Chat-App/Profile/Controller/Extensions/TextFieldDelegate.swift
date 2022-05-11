//
//  TextFieldDelegate.swift
//  Chat-App
//
//  Created by Станислав on 06.03.2022.
//

import UIKit

extension ProfileViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard
            let fullNameText = fullNameTextField.text,
            let descriptionText = userDescriptionTextField.text
        else { return }
        
        userProfileInfo.name = fullNameText
        userProfileInfo.description = descriptionText
        
        let stringInput = fullNameText.components(separatedBy: " ").prefix(2)
        var fullNameInitials = ""
        
        for string in stringInput {
            fullNameInitials += String(string.first ?? " ")
        }
        
        initialsFullNameLabel.text = fullNameInitials
        
        if fullNameText.isEmpty, descriptionText.isEmpty {
            setUIWithEditState(state: .hasNotChange)
            return
        }
        setUIWithEditState(state: .hasChange)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == fullNameTextField {
            userDescriptionTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
}
