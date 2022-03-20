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
     
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCustomNavigationBar()
        navigationController?.navigationBar.addSubview(createCustomTitleView())
        
        fullNameTextField.delegate = self
        userDescriptionTextField.delegate = self
        
        cancelButton.layer.cornerRadius = 10
        cancelButton.isHidden = true
        
        saveGCDButton.layer.cornerRadius = 10
        saveGCDButton.isHidden = true
        saveGCDButton.isEnabled = false
        
        saveOperationsButton.layer.cornerRadius = 10
        saveOperationsButton.isHidden = true
        saveOperationsButton.isEnabled = false
        
        [fullNameTextField, userDescriptionTextField].forEach {
            $0?.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        }
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
        fullNameTextField.isEnabled = true
        userDescriptionTextField.isEnabled = true
        
        fullNameTextField.becomeFirstResponder()
        
        editButton.isHidden.toggle()
        cancelButton.isHidden.toggle()
        saveGCDButton.isHidden.toggle()
        saveOperationsButton.isHidden.toggle()

//        presentChooseImageAlertController()
    }
    
    // MARK: - Public Methods
    @objc func closeBarButtonPressed() {
        dismiss(animated: true, completion: nil)
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
}
