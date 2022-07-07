//
//  ProfileImagePickerCollectionViewDataSource.swift
//  Chat-App
//
//  Created by Станислав on 05.07.2022.
//

import UIKit

class ProfileImagePickerCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var imageURLs: [Picture] = []
    var collectionViewController: ProfileImagePickerViewController?
    var cache = NSCache<NSNumber, UIImage>()
    
    private let networkConfigFactory: ConfigFactory
    private let requestService: RequestSender
    
    init(networkConfigFactory: ConfigFactory, requestService: RequestSender) {
        self.networkConfigFactory = networkConfigFactory
        self.requestService = requestService
        
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.collectionViewCellIdentifier,
            for: indexPath
        ) as? ProfileImagePickerViewCell else { return UICollectionViewCell() }
        
        let imageURL = imageURLs[indexPath.row]
        let key = NSNumber(value: indexPath.row)
        let config = networkConfigFactory.imageConfig(stringURL: imageURL.quality.imageURL)
        
        if let image = cache.object(forKey: key) {
            cell.image = image
        } else {
            let task = Task {
                requestService.send(config: config) { [weak self] result in
                    switch result {
                    case .success(let image):
                        if !Task.isCancelled {
                            cell.image = image
                            self?.cache.setObject(image, forKey: key)
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            
            cell.task = task
        }
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            guard let footerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: Constants.loadingReusableViewIdetifier,
                for: indexPath
            ) as? LoadingReusableView else { return UICollectionReusableView() }
            
            collectionViewController?.loadingReusableView = footerView
            
            return footerView
        }
        
        return UICollectionReusableView()
    }
}
