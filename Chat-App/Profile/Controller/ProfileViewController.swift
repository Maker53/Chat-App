//
//  ProfileViewController.swift
//  Chat-App
//
//  Created by Станислав on 19.02.2022.
//

import UIKit

// MARK: - State
enum State {
    case willEditing
    case hasChange
    case hasNotChange
    case willSavingData
    case didSavingData
    case didEditing
    case cancelled
}

// MARK: - ProfileViewController
class ProfileViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveGCDButton: UIButton!
    @IBOutlet weak var saveOperationsButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var initialsFullNameLabel: UILabel!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var userDescriptionTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Public Properties
    var userProfileInfo: UserProfileInfo!
     
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setInitialSettings()
        //TODO: Установить тему 
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        StorageManager.shared.fetchViaGCD(from: Constants.userInfoFileNameForSave) {
            self.userProfileInfo = $0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        view.endEditing(true)
    }
    
    // MARK: - IB Actions
    @IBAction func editButtonPressed() {
        setUIWithEditState(state: .willEditing)
        fullNameTextField.becomeFirstResponder()
    }
    
    @IBAction func cancelButtonPressed() {
        setUIWithEditState(state: .cancelled)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        userProfileInfo = UserProfileInfo(
            name: fullNameTextField.text,
            description: userDescriptionTextField.text,
            imageData: profileImage.image?.pngData())
        
        setUIWithEditState(state: .willSavingData)
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        if sender.tag == 0 {
            // GCD
            StorageManager.shared.saveViaGCD(
                with: userProfileInfo,
                and: Constants.userInfoFileNameForSave) {
                    self.activityIndicator.stopAnimating()
                    self.setUIWithEditState(state: .didSavingData)
                    self.presentSuccessSavingAlertController()
                }
        } else {
            // Operations
            let saveQueue = OperationQueue()
            saveQueue.maxConcurrentOperationCount = 1
            
            let saveOperation = SaveUserInfoOperation(object: userProfileInfo, fileName: Constants.userInfoFileNameForSave)
            
            saveOperation.completionBlock = {
                OperationQueue.main.addOperation {
                    self.activityIndicator.stopAnimating()
                    self.setUIWithEditState(state: .didSavingData)
                    self.presentSuccessSavingAlertController()
                }
            }
            
            saveQueue.addOperation(saveOperation)
        }
    }
    
    // MARK: - Public Methods
    @objc func closeBarButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    func setUIWithEditState(state: State) {
        switch state {
        case .willEditing:
            fullNameTextField.isEnabled = true
            userDescriptionTextField.isEnabled = true
            
            editButton.isHidden = true
            cancelButton.isHidden = false
            saveGCDButton.isHidden = false
            saveOperationsButton.isHidden = false
        case .hasChange:
            saveGCDButton.isEnabled = true
            saveOperationsButton.isEnabled = true
            
            if profileImage.image != nil {
                initialsFullNameLabel.text = nil
            }
        case .hasNotChange, .willSavingData:
            saveGCDButton.isEnabled = false
            saveOperationsButton.isEnabled = false
        case .didSavingData:
            saveGCDButton.isEnabled = true
            saveOperationsButton.isEnabled = true
        case .didEditing:
            fullNameTextField.isEnabled = false
            userDescriptionTextField.isEnabled = false
            
            editButton.isHidden = false
            cancelButton.isHidden = true
            saveGCDButton.isHidden = true
            saveOperationsButton.isHidden = true
            
            saveGCDButton.isEnabled = false
            saveOperationsButton.isEnabled = false
        case .cancelled:
            fullNameTextField.isEnabled = false
            userDescriptionTextField.isEnabled = false
            
            editButton.isHidden = false
            cancelButton.isHidden = true
            saveGCDButton.isHidden = true
            saveOperationsButton.isHidden = true
            
            saveGCDButton.isEnabled = false
            saveOperationsButton.isEnabled = false
            
            fullNameTextField.text = nil
            userDescriptionTextField.text = nil
            profileImage.image = nil
            initialsFullNameLabel.text = nil
        }
    }
}

// MARK: - Private Methods
extension ProfileViewController {
    @objc private func chooseImage() {
        presentChooseImageAlertController()
    }
    
    private func setInitialSettings() {
        createCustomNavigationBar()
        navigationController?.navigationBar.addSubview(createCustomTitleView())
        
        if let userProfileInfo = userProfileInfo {
            fullNameTextField.text = userProfileInfo.name
            userDescriptionTextField.text = userProfileInfo.description
            if let imageData = userProfileInfo.imageData {
                profileImage.image = UIImage(data: imageData)
            } else if let fullNameText = fullNameTextField.text {
                let stringInput = fullNameText.components(separatedBy: " ").prefix(2)
                var fullNameInitials = ""
                
                for string in stringInput {
                    fullNameInitials += String(string.first ?? " ")
                }
                
                initialsFullNameLabel.text = fullNameInitials
            }
        }
        
        fullNameTextField.delegate = self
        userDescriptionTextField.delegate = self
        
        fullNameTextField.isEnabled = false
        userDescriptionTextField.isEnabled = false
        
        editButton.layer.cornerRadius = 10
        
        cancelButton.layer.cornerRadius = 10
        cancelButton.isHidden = true
        
        saveGCDButton.layer.cornerRadius = 10
        saveGCDButton.tag = 0
        saveGCDButton.isHidden = true
        saveGCDButton.isEnabled = false
        
        saveOperationsButton.layer.cornerRadius = 10
        saveOperationsButton.tag = 1
        saveOperationsButton.isHidden = true
        saveOperationsButton.isEnabled = false
        
        profileImage.isUserInteractionEnabled = true
        let tapToProfileImage = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        profileImage.addGestureRecognizer(tapToProfileImage)
    }
}
