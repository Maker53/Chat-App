//
//  ProfileImagePickerViewController.swift
//  Chat-App
//
//  Created by Станислав on 05.07.2022.
//

import UIKit

class ProfileImagePickerViewController: UIViewController {
    
    // MARK: - UI
    
    var mainView: ProfileImagePickerView? {
        view as? ProfileImagePickerView
    }
    
    // MARK: - Private Properties
    
    private let collectionViewDataSource: UICollectionViewDataSource
    private let collectionViewDelegate: UICollectionViewDelegate
    
    // MARK: - Initializers
    
    init() {
        collectionViewDataSource = ProfileImagePickerCollectionViewDataSource()
        collectionViewDelegate = ProfileImagePickerCollectionViewDelegate()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    
    override func loadView() {
        view = ProfileImagePickerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView?.collectionView.dataSource = collectionViewDataSource
        mainView?.collectionView.delegate = collectionViewDelegate
    }
}
