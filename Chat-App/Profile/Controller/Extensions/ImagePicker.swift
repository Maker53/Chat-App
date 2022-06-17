//
//  ImagePicker.swift.swift
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
        DispatchQueue.global().async { [weak self] in
            if let image = info[.originalImage] as? UIImage {
                DispatchQueue.main.async {
                    self?.mainView?.initialsLabel.text = nil
                    self?.mainView?.userImageView.image = image
                    self?.setUIWithEditState(.hasChange)
                }
            }
        }
        
        dismiss(animated: true)
    }
}
