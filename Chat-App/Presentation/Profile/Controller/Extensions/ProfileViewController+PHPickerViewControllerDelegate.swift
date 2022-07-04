//
//  ProfileViewController+PHPickerViewControllerDelegate.swift
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
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, _ in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        self?.mainView?.initialsLabel.text = nil
                        self?.mainView?.userImageView.image = image
                        self?.setUIWithEditState(.hasChange)
                    }
                }
            }
        }
    }
}
