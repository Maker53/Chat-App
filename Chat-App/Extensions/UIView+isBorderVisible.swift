//
//  UIView+isBorderVisible.swift
//  Chat-App
//
//  Created by Станислав on 12.06.2022.
//

import UIKit

extension UIView {
    
    var isBorderVisible: Bool {
        get { layer.borderWidth == 3 ? true : false }
        set {
            layer.borderWidth = newValue ? 3 : 0
            layer.borderColor = newValue ? UIColor.lightGray.cgColor : UIColor.clear.cgColor
        }
    }
}
