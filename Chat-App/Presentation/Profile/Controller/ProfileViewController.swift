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
    var currentMultithreadingService: MultithreadingService?
    
    // MARK: - Services
    
    let gcdService: MultithreadingService!
    let operationService: MultithreadingService!
    private let themeService: ThemeService!
    
    // MARK: - Initializers
    
    init() {
        self.gcdService = ServiceAssembly.gcdService
        self.operationService = ServiceAssembly.operationService
        self.themeService = ServiceAssembly.themeService
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        currentMultithreadingService?.saveData(userProfileInfo, completion: { [weak self] isSaved in
            self?.mainView?.activityIndicator.stopAnimating()
            
            if isSaved {
                self?.setUIWithEditState(.didSaving)
                UIAlertController().presentSuccessSavingAlert()
            } else {
                UIAlertController().presentSaveErrorAlert()
            }
        })
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
    
    func presentChooseImageAlertController() {
        let photoLibraryIcon = UIImage(systemName: "photo")
        let cameraIcon = UIImage(systemName: "camera")
        let imagePickerIcon = UIImage(systemName: "network")
        
        let alertController = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        
        let photoAction = UIAlertAction(title: "Photo", style: .default) { [unowned self] _ in
            if #available(iOS 14, *) {
                self.choosePHPicker()
            } else {
                self.chooseImagePicker(source: .photoLibrary)
            }
        }
        
        photoAction.setValue(photoLibraryIcon, forKey: "image")
        photoAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [unowned self] _ in
            self.chooseImagePicker(source: .camera)
        }
        
        cameraAction.setValue(cameraIcon, forKey: "image")
        cameraAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let imagePickerAction = UIAlertAction(title: "Download", style: .default) { [unowned self] _ in
            self.showImagePickerController()
        }
        
        imagePickerAction.setValue(imagePickerIcon, forKey: "image")
        imagePickerAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(photoAction)
        alertController.addAction(cameraAction)
        alertController.addAction(imagePickerAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}

// MARK: - Private Methods

extension ProfileViewController {
    
    private func setupNavigationBar() {
        let closeButton = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(closeProfileViewAction))
        navigationItem.rightBarButtonItem = closeButton
    }
    
    private func fetchData() {
        gcdService.fetchData { [weak self] profile in
            self?.userProfileInfo = profile
            self?.setupFields()
        }
    }
    
    private func showImagePickerController() {
        let imagePickerController = ProfileImagePickerViewController()
        
        imagePickerController.onCompletion = { [unowned self] image in
            self.mainView?.userImageView.image = image
            self.mainView?.initialsLabel.text = nil
            self.mainView?.userImageView.image = image
            self.setUIWithEditState(.hasChange)
        }
        
        present(imagePickerController, animated: true)
    }
    
    private func updateTheme() {
        let themeDesign = themeService.getCurrentThemeDesign()
        
        mainView?.backgroundColor = themeDesign.backgroundColor
        mainView?.userNameTextField.textColor = themeDesign.labelColor
        mainView?.cancelButton.backgroundColor = themeDesign.buttonBackgroundColor
        mainView?.editButton.backgroundColor = themeDesign.buttonBackgroundColor
        mainView?.gcdButton.backgroundColor = themeDesign.buttonBackgroundColor
        mainView?.operationButton.backgroundColor = themeDesign.buttonBackgroundColor
    }
    
    // MARK: - Target Actions Methods
    
    @objc private func closeProfileViewAction() {
        dismiss(animated: true)
    }
}
