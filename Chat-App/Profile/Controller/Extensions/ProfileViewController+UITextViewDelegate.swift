//
//  ProfileViewController+UITextViewDelegate.swift
//  Chat-App
//
//  Created by Станислав on 14.06.2022.
//

import UIKit

extension ProfileViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "About me" {
            textView.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let description = mainView?.descriptionTextView.text, !description.isBlank else {
            textView.text = "About me"
            
            return
        }
        
        if isDataChange() {
            setUIWithEditState(.hasChange)
        } else {
            setUIWithEditState(.hasNotChange)
        }
    }
}
