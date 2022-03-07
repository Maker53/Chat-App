//
//  TextViewDelegate.swift
//  Chat-App
//
//  Created by Станислав on 06.03.2022.
//

import UIKit

extension ProfileViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        let stringInput = fullNameTextView.text.components(separatedBy: " ")
        var fullNameInitials = ""
        
        for string in stringInput {
            fullNameInitials += String(string.first ?? Character(""))
        }
        
        initialsFullNameLabel.text = fullNameInitials
    }
}
