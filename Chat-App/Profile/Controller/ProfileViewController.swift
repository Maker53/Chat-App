//
//  ProfileViewController.swift
//  Chat-App
//
//  Created by Станислав on 19.02.2022.
//

import UIKit

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
    var userProfileInfo = UserProfileInfo()
     
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInitialSettings()
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
    @IBAction func editImageButtonPressed() {
        toggleTextFieldStateWhenEditingStartsAndEnds()
        fullNameTextField.becomeFirstResponder()
        toggleButtonStateWhenEditingStartsAndEnds()
    }
    
    @IBAction func cancelButtonPressed() {
        fullNameTextField.text = ""
        userDescriptionTextField.text = ""
        profileImage.image = nil
        // Когда будут сохраняться данные пользователя не забыть здесь возвращать
        // последние сохраненные данные
        initialsFullNameLabel.text = ""
    
        if initialsFullNameLabel.isHidden {
            initialsFullNameLabel.isHidden.toggle()
        }
        
        toggleTextFieldStateWhenEditingStartsAndEnds()
        toggleButtonStateWhenEditingStartsAndEnds()
    }
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if sender.tag == 0 {
            StorageManager.shared.save(userProfileInfo, with: "UserProfileInfo.json")
        } else {
            guard let userProfile = StorageManager.shared.fetchObject(from: "UserProfileInfo.json") else { return }
            userProfileInfo = userProfile
            if let imageData = userProfileInfo.imageData {
                profileImage.image = UIImage(data: imageData)
            }
            fullNameTextField.text = userProfileInfo.name
            userDescriptionTextField.text = userProfileInfo.description
        }
    }
    
    // MARK: - Public Methods
    @objc func closeBarButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    func toggleTextFieldStateWhenEditingStartsAndEnds() {
        fullNameTextField.isEnabled.toggle()
        userDescriptionTextField.isEnabled.toggle()
    }
    
    func toggleButtonStateWhenEditingStartsAndEnds() {
        editButton.isHidden.toggle()
        cancelButton.isHidden.toggle()
        saveGCDButton.isHidden.toggle()
        saveOperationsButton.isHidden.toggle()
    }
    
    // MARK: - Private Methods
    @objc private func editingChanged(_ sender: UITextField) {
        guard
            let fullNameText = fullNameTextField.text,
            let descriptionText = userDescriptionTextField.text
        else { return }
        
        if fullNameText.isEmpty, descriptionText.isEmpty {
            saveGCDButton.isEnabled = false
            saveOperationsButton.isEnabled = false
            return
        }
        
        saveGCDButton.isEnabled = true
        saveOperationsButton.isEnabled = true
    }
    
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
        
        [fullNameTextField, userDescriptionTextField].forEach {
            $0?.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        }
        
        profileImage.isUserInteractionEnabled = true
        let tapToProfileImage = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        profileImage.addGestureRecognizer(tapToProfileImage)
    }
}
