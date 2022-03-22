//
//  PHPicker.swift
//  Chat-App
//
//  Created by Станислав on 01.03.2022.
//

import PhotosUI

extension ProfileViewController: PHPickerViewControllerDelegate {
    
    @available(iOS 14.0, *)
    func choosePHPicker() {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        let newFilter = PHPickerFilter.images
        
        configuration.filter = newFilter
        configuration.preferredAssetRepresentationMode = .current
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        present(picker, animated: true)
    }
    
    @available(iOS 14, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                if let image = object as? UIImage {
                    self.userProfileInfo.imageData = image.pngData()
                    
                    DispatchQueue.main.async {
                        self.profileImage.image = image
                        
                        if !self.initialsFullNameLabel.isHidden {
                            self.initialsFullNameLabel.isHidden.toggle()
                            
                        self.saveGCDButton.isEnabled = true
                        self.saveOperationsButton.isEnabled = true
                        self.toggleButtonStateWhenEditingStartsAndEnds()
                        self.toggleTextFieldStateWhenEditingStartsAndEnds()
                        }
                    }
                }
            }
        }
    }
}
