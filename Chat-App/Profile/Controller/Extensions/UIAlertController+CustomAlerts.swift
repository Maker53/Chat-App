//
//  UIAlertController+CustomAlerts.swift
//  Chat-App
//
//  Created by Станислав on 17.06.2022.
//

import UIKit

extension UIAlertController {
    func presentSuccessSavingAlert() {
        let alertController = UIAlertController(title: "Data saved", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        alertController.addAction(okAction)
        
        presentAlertController(alertController)
    }
    
    func presentSaveErrorAlert() {
        let profileController = ProfileViewController()
        let alertController = UIAlertController(title: "Error", message: "Data doesn't save", preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak profileController] _ in
            _ = profileController?.saveData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(retryAction)
        alertController.addAction(cancelAction)
        
        presentAlertController(alertController)
    }
    
    private func presentAlertController(_ alert: UIAlertController) {
        let rootViewController = UIApplication.shared.delegate?.window??.rootViewController as? UINavigationController
        let presentedController = rootViewController?.visibleViewController as? ProfileViewController
        
        if let presentedController = presentedController {
            presentedController.present(alert, animated: true)
        } else {
            rootViewController?.present(alert, animated: true)
        }
    }
}
