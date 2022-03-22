//
//  ChooseImagePicker.swift
//  Chat-App
//
//  Created by Станислав on 27.02.2022.
//

import UIKit

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = source
            
            present(imagePicker, animated: true)
        }
    }
    
    // iOS 13.0
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // убрать с main потока
        guard let image = info[.originalImage] as? UIImage else { return }
        userProfileInfo.imageData = image.pngData()
        
        profileImage.image = image
        
        if !initialsFullNameLabel.isHidden {
            initialsFullNameLabel.isHidden.toggle()
        }
        
        toggleButtonStateWhenEditingStartsAndEnds()
        toggleTextFieldStateWhenEditingStartsAndEnds()
        dismiss(animated: true)
    }
}
