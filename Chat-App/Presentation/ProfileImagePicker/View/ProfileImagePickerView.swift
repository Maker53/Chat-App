//
//  ProfileImagePickerView.swift
//  Chat-App
//
//  Created by Станислав on 05.07.2022.
//

import UIKit

class ProfileImagePickerView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let inset: CGFloat = 8
        
        layout.minimumLineSpacing = inset
        layout.minimumInteritemSpacing = inset
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(ProfileImagePickerViewCell.self, forCellWithReuseIdentifier: Constants.collectionViewCellIdentifier)
        collectionView.register(
            LoadingReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: Constants.loadingReusableViewIdetifier)
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                        
        addSubview(collectionView)
        
        setupSubvies()
        setupLayout()
        updateTheme()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateTheme() {
        let themeDesign = ServiceAssembly.themeService.getCurrentThemeDesign()
        let themeBackgroundColor = themeDesign.backgroundColor
        
        backgroundColor = themeBackgroundColor
        collectionView.backgroundColor = themeBackgroundColor
    }
    
    private func setupSubvies() {
        addSubview(collectionView)
    }
    
    private func setupLayout() {
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
