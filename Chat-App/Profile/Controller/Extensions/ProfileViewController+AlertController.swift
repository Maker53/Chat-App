//
//  ProfileViewController+AlertController.swift
//  Chat-App
//
//  Created by Станислав on 27.02.2022.
//

import UIKit

extension ProfileViewController {
    func presentChooseImageAlertController() {
        let alertController = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        
        let photo = UIAlertAction(title: "Photo", style: .default) { _ in
            // add photo
        }
        
        let camera = UIAlertAction(title: "Camera", style: .default) { _ in
            // add camera
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(photo)
        alertController.addAction(camera)
        alertController.addAction(cancel)
        
        present(alertController, animated: true)
    }
}
