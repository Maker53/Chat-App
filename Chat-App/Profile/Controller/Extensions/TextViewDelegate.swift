//
//  TextViewDelegate.swift
//  Chat-App
//
//  Created by Станислав on 06.03.2022.
//

import UIKit

extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let stringInput = fullNameTextField.text?.components(separatedBy: " ") ?? []
        var fullNameInitials = ""
        
        for string in stringInput {
            fullNameInitials += String(string.first ?? " ")
        }
        
        initialsFullNameLabel.text = fullNameInitials
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
