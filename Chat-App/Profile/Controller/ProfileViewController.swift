//
//  ProfileViewController.swift
//  Chat-App
//
//  Created by Станислав on 19.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    // MARK: - Visual Components
    var mainView: ProfileView? {
        view as? ProfileView
    }
     
    // MARK: - View Lifecycle Methods
    override func loadView() {
        view = ProfileView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView?.delegate = self
        
        setupNavigationBar()
        hideKeyboardWhenTappedAround()
        updateTheme()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let width = mainView?.userImageView.bounds.width else { return }
        mainView?.userImageView.layer.cornerRadius = width / 2
    }
}

// MARK: - Private Methods
extension ProfileViewController {
    private func setupNavigationBar() {
        let closeButton = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(closeProfileViewAction))
        navigationItem.rightBarButtonItem = closeButton
    }
    
    // MARK: - Target Actions Methods
    @objc private func closeProfileViewAction() {
        dismiss(animated: true)
    }
}

extension ProfileViewController: ThemeServiceDelegate {
    func updateTheme() {
        let themeDesign = ThemeService().getCurrentThemeDesign()
        
        mainView?.backgroundColor = themeDesign.backgroundColor
        mainView?.cancelButton.backgroundColor = themeDesign.buttonBackgroundColor
        mainView?.editButton.backgroundColor = themeDesign.buttonBackgroundColor
        mainView?.gcdButton.backgroundColor = themeDesign.buttonBackgroundColor
        mainView?.operationButton.backgroundColor = themeDesign.buttonBackgroundColor
    }
}
