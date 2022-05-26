//
//  ThemesViewController.swift
//  Chat-App
//
//  Created by Станислав on 13.03.2022.
//

import UIKit

class ThemesViewController: UIViewController {
    // MARK: - Public Properties
    lazy var classicThemeButton = UIButton()
    lazy var dayThemeButton = UIButton()
    lazy var nightThemeButton = UIButton()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupThemeViewController()
        setTheme()
    }
    
    // MARK: - Buttons Actions
    @objc func changeThemeButtonPressed(_ sender: Any) {
        switch Theme.current {
        case .day: dayThemeButton.selectedState = false
        case .night: nightThemeButton.selectedState = false
        default: classicThemeButton.selectedState = false
        }
        
        if let tapGestureRecognizer = sender as? UITapGestureRecognizer {
            guard let stackView = tapGestureRecognizer.view as? UIStackView else { return }
            
            switch stackView.tag {
            case 1:
                dayThemeButton.selectedState = true
                Theme.day.save()
            case 2:
                nightThemeButton.selectedState = true
                Theme.night.save()
            default:
                classicThemeButton.selectedState = true
                Theme.classic.save()
            }
            
            setTheme()
        }
    }
    
    @objc func cancelBarButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setTheme() {
        switch Theme.current {
        case .day:
            view.backgroundColor = .blue
            if !dayThemeButton.selectedState {
                dayThemeButton.selectedState = true
            }
        case .night:
            view.backgroundColor = .systemGray
            if !nightThemeButton.selectedState {
                nightThemeButton.selectedState = true
            }
        default:
            view.backgroundColor = .systemBackground
            if !classicThemeButton.selectedState {
                classicThemeButton.selectedState = true
            }
        }
    }
}

// MARK: - Extension for UIButton
extension UIButton {
    var selectedState: Bool {
        get { layer.borderWidth == 3 ? true : false }
        set {
            layer.borderWidth = newValue ? 3 : 1
            layer.borderColor = newValue
                ? CGColor(red: 4/255, green: 51/255, blue: 255/255, alpha: 1)
                : CGColor(red: 255, green: 255, blue: 255, alpha: 0.75)
        }
    }
}
