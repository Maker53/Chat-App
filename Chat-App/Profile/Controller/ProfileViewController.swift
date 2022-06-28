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
    
    // MARK: - Public Properties
    
    var userProfileInfo: UserProfileInfo!
    var dataManager: MultithreadingManager = GCDManager()
     
    // MARK: - View Lifecycle Methods
    
    override func loadView() {
        view = ProfileView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        setupNavigationBar()
        hideKeyboardWhenTappedAround()
        updateTheme()
        
        mainView?.delegate = self
        mainView?.userNameTextField.delegate = self
        mainView?.descriptionTextView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let width = mainView?.userImageView.bounds.width else { return }
        mainView?.userImageView.layer.cornerRadius = width / 2
    }
    
    // MARK: - Public Methods
    
    func saveData() {
        dataManager.saveData(userProfileInfo) { [weak self] isSaved in
            self?.mainView?.activityIndicator.stopAnimating()
            
            if isSaved {
                self?.setUIWithEditState(.didSaving)
                UIAlertController().presentSuccessSavingAlert()
            } else {
                UIAlertController().presentSaveErrorAlert()
            }
        }
    }
    
    func setupFields() {
        if let description = userProfileInfo?.description, !description.isBlank {
            mainView?.descriptionTextView.text = userProfileInfo?.description
        }
        
        if let userImageData = userProfileInfo?.imageData {
            mainView?.userImageView.image = UIImage(data: userImageData)
            mainView?.initialsLabel.text = ""
        }
        
        let fullName = userProfileInfo.name
        
        mainView?.userNameTextField.text = fullName
        setupInitialsLabel(fullName: fullName)
    }
    
    func isDataChange() -> Bool {
        if mainView?.userNameTextField.text != userProfileInfo.name
            || mainView?.descriptionTextView.text != userProfileInfo.description {
            return true
        }
        
        if let data = userProfileInfo.imageData,
           let image = mainView?.userImageView.image,
           image.isEqual(UIImage(data: data)) {
            return true
        }
        
        return false
    }
    
    func setupInitialsLabel(fullName: String?) {
        guard let fullName = fullName else { return }
        let stringInput = fullName.components(separatedBy: " ").prefix(2)
        var fullNameInitials = ""
        
        for string in stringInput {
            fullNameInitials += String(string.first ?? " ")
        }
        
        if mainView?.userImageView.image == nil {
            mainView?.initialsLabel.text = fullNameInitials
        }
    }
}

// MARK: - Private Methods

extension ProfileViewController {
    private func setupNavigationBar() {
        let closeButton = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(closeProfileViewAction))
        navigationItem.rightBarButtonItem = closeButton
    }
    
    private func fetchData() {
        dataManager.fetchData { [weak self] profile in
            self?.userProfileInfo = profile
            self?.setupFields()
        }
    }
    
    // MARK: - Target Actions Methods
    @objc private func closeProfileViewAction() {
        dismiss(animated: true)
    }
}

// MARK: - Theme Service Delegate

extension ProfileViewController: ThemeServiceDelegate {
    func updateTheme() {
        let themeDesign = ThemeService().getCurrentThemeDesign()
        
        mainView?.backgroundColor = themeDesign.backgroundColor
        mainView?.userNameTextField.textColor = themeDesign.labelColor
        mainView?.cancelButton.backgroundColor = themeDesign.buttonBackgroundColor
        mainView?.editButton.backgroundColor = themeDesign.buttonBackgroundColor
        mainView?.gcdButton.backgroundColor = themeDesign.buttonBackgroundColor
        mainView?.operationButton.backgroundColor = themeDesign.buttonBackgroundColor
    }
}
