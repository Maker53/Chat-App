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
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var initialsFullNameLabel: UILabel!
    @IBOutlet weak var fullNameTextView: UITextView!
     
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullNameTextView.delegate = self
        
        createCustomNavigationBar()
        navigationController?.navigationBar.addSubview(createCustomTitleView())
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
        presentChooseImageAlertController()
    }
    
    // MARK: - Methods
    @objc func closeBarButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
}
