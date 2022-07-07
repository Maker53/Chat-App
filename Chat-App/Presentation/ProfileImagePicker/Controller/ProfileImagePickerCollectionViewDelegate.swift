//
//  ProfileImagePickerCollectionViewDelegate.swift
//  Chat-App
//
//  Created by Станислав on 05.07.2022.
//

import UIKit

class ProfileImagePickerCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    
    var imageURLs: [Picture] = []
    var collectionViewController: ProfileImagePickerViewController?
    
    private var isLoading = false
    
    // MARK: - CollectionViewDelegate Methods
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let key = NSNumber(value: indexPath.row)
        guard let image = collectionViewController?.collectionViewDataSource.cache.object(forKey: key) else {
            let alertController = UIAlertController(title: "Error", message: "Image hasn't been upload yet", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel)
            
            alertController.addAction(okAction)
            
            collectionViewController?.present(alertController, animated: true)
            
            return
        }
        
        collectionViewController?.onCompletion?(image)
        collectionViewController?.dismiss(animated: true)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForFooterInSection section: Int
    ) -> CGSize {
        if isLoading {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: 55)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplaySupplementaryView view: UICollectionReusableView,
        forElementKind elementKind: String,
        at indexPath: IndexPath
    ) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            collectionViewController?.loadingReusableView.activityIndicator.startAnimating()
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplayingSupplementaryView view: UICollectionReusableView,
        forElementOfKind elementKind: String,
        at indexPath: IndexPath
    ) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            collectionViewController?.loadingReusableView.activityIndicator.stopAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == imageURLs.count - 1 && !isLoading {
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) { [weak self] in
                self?.loadMoreData(collectionView)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func getLayoutInset(_ layout: UICollectionViewLayout) -> CGFloat {
        guard let layout = layout as? UICollectionViewFlowLayout else { return 0 }
        
        return layout.minimumInteritemSpacing
    }
    
    private func loadMoreData(_ collectionView: UICollectionView) {
        if !isLoading {
            isLoading = true
            DispatchQueue.global().async { [weak self] in
                self?.collectionViewController?.fetchImageList()
                self?.isLoading = false
            }
        }
    }
}
