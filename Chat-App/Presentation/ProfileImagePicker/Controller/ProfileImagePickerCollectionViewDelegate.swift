//
//  ProfileImagePickerCollectionViewDelegate.swift
//  Chat-App
//
//  Created by Станислав on 05.07.2022.
//

import UIKit

class ProfileImagePickerCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset = getLayoutInset(collectionViewLayout)
        let size = (collectionView.frame.width - inset * 4) / 3
        
        return CGSize(width: size, height: size)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        let inset = getLayoutInset(collectionViewLayout)
        
        return UIEdgeInsets(top: inset, left: inset, bottom: 0, right: inset)
    }
    
    private func getLayoutInset(_ layout: UICollectionViewLayout) -> CGFloat {
        guard let layout = layout as? UICollectionViewFlowLayout else { return 0 }
        
        return layout.minimumInteritemSpacing
    }
}
