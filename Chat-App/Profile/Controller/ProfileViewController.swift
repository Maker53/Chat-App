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
    case didEditing
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
    
    // MARK: - Public Properties
    var userProfileInfo: UserProfileInfo?
     
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
        setUIWithEditState(state: .didEditing)
    }
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        // GCD
        // Operations
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
        case .hasNotChange:
            saveGCDButton.isEnabled = false
            saveOperationsButton.isEnabled = false
        case .didEditing:
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
            // TODO: Когда будут сохраняться данные пользователя не забыть здесь
            // TODO: возвращать последние сохраненные данные
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
