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
    
    // В данном методе происходит инициализация объекта класса UIViewController
    // view и IBOutlets еще не загружены и поэтому не могут быть отображены их свойства
//
//    required init?(coder: NSCoder) {
//        print(saveButton.frame)
//    }
     
    // MARK: - Override Methods
    // saveButton.frame == (77.5, 614.0, 220.0, 33.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullNameTextView.delegate = self
        
        createCustomNavigationBar()
        navigationController?.navigationBar.addSubview(createCustomTitleView())

        print(saveButton.frame)
    }
    
    // saveButton.frame == (77.5, 614.0, 220.0, 33.0)
    // saveButton.frame == (97.0, 683.0, 220.0, 33.0)
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        
        print(saveButton.frame)
    }
    
    // saveButton.frame == (97.0, 683.0, 220.0, 33.0)
    // Метод viewWillLayoutSubviews() вызывается 2 раза:
    // 1 раз - с констрейнтами, указанными в сторибоарде
    // 2 раз - с пересчитанными констрейнтами под конкретный экран на запускаемом устройстве
    // так как экраны разные, то и констрейнты могут быть увеличены или уменьшены.
    // В данном методе констрейнты уже расставлены, поэтому мы видим пересчитанные размеры.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(saveButton.frame)
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
//        dismiss(animated: true, completion: nil)
    }
}
