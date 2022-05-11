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
        // TODO: убрать с main потока
        if let image = info[.originalImage] as? UIImage {
            userProfileInfo.imageData = image.pngData()
            
            DispatchQueue.main.async {
                self.profileImage.image = image
                
                self.setUIWithEditState(state: .willEditing)
                self.setUIWithEditState(state: .hasChange)
            }
        }
        
        dismiss(animated: true)
    }
}
