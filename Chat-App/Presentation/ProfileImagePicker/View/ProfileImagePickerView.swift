//
//  ProfileImagePickerView.swift
//  Chat-App
//
//  Created by Станислав on 05.07.2022.
//

import UIKit

class ProfileImagePickerView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.collectionViewCellIdentifier)
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
