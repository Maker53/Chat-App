//
//  ProfileViewController+TextFieldDelegate.swift
//  Chat-App
//
//  Created by Станислав on 06.03.2022.
//

import UIKit

extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let fullName = mainView?.userNameTextField.text else { return }

        setupInitialsLabel(fullName: fullName)
        
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
