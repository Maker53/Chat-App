//
//  LoadingReusableView.swift
//  Chat-App
//
//  Created by Станислав on 07.07.2022.
//

import UIKit

class LoadingReusableView: UICollectionReusableView {
    
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(activityIndicator)
        activityIndicator.center = center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
