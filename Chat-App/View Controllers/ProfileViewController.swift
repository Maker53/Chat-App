//
//  ProfileViewController.swift
//  Chat-App
//
//  Created by Станислав on 19.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
    }
}
