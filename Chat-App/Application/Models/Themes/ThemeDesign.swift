//
//  ThemeDesign.swift
//  Chat-App
//
//  Created by Станислав on 12.06.2022.
//

import UIKit

protocol ThemesDesign {
    var labelColor: UIColor { get set }
    var backgroundColor: UIColor { get set }
    var incomingMessageColor: UIColor { get set }
    var outgoingMessageColor: UIColor { get set }
    var navigationBarColor: UIColor { get set }
    var titleColor: UIColor { get set }
    var buttonBackgroundColor: UIColor { get set }
}
