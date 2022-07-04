//
//  ProfileViewController+UIStates.swift
//  Chat-App
//
//  Created by Станислав on 13.06.2022.
//

import UIKit

enum UIState {
    
    case willEditing
    case hasChange
    case hasNotChange
    case didSaving
    case cancelled
}

extension ProfileViewController {
    
    func setUIWithEditState(_ state: UIState) {
        func isStartEdit(_ bool: Bool) {
            mainView?.editButton.isHidden = bool
            mainView?.editImageButton.isEnabled = bool
            mainView?.gcdButton.isHidden = !bool
            mainView?.operationButton.isHidden = !bool
            mainView?.cancelButton.isHidden = !bool
            mainView?.userNameTextField.isEnabled = bool
            mainView?.descriptionTextView.isEditable = bool
        }
        
        switch state {
        case .willEditing:
            isStartEdit(true)
            mainView?.userNameTextField.becomeFirstResponder()
            mainView?.gcdButton.isEnabled = false
            mainView?.operationButton.isEnabled = false
        case .hasChange:
            mainView?.gcdButton.isEnabled = true
            mainView?.operationButton.isEnabled = true
        case .hasNotChange:
            mainView?.gcdButton.isEnabled = false
            mainView?.operationButton.isEnabled = false
        case .didSaving:
            isStartEdit(false)
        case .cancelled:
            setupFields()
            isStartEdit(false)
        }
    }
}
