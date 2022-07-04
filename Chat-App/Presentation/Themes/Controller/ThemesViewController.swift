//
//  ThemesViewController.swift
//  Chat-App
//
//  Created by Станислав on 13.03.2022.
//

import UIKit

class ThemesViewController: UIViewController {
    
    // MARK: - Visual Components
    
    var mainView: ThemesView? {
        view as? ThemesView
    }
    
    // MARK: - Public Properties
    
    var onCompletion: (() -> Void)?
    
    // MARK: - Private Properties
    
    private let themeService = ServiceAssembly.themeService
    
    // MARK: - Override Methods
    
    override func loadView() {
        view = ThemesView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView?.delegate = self
        
        setupNavigationBar()
        updateTheme()
    }
}

// MARK: - Target Actions

extension ThemesViewController {
    
    @objc private func cancelBarButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Private Methods

extension ThemesViewController {
    
    private func setupNavigationBar() {
        title = "Settings"
        navigationItem.hidesBackButton = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelBarButtonPressed)
        )
    }
    
    private func updateTheme() {
        let themeDesign = themeService.getCurrentThemeDesign()
        
        mainView?.backgroundColor = themeDesign.backgroundColor
        mainView?.classicLabel.textColor = themeDesign.labelColor
        mainView?.dayLabel.textColor = themeDesign.labelColor
        mainView?.nightLabel.textColor = themeDesign.labelColor
    }
}

// MARK: - Themes View Delegate

extension ThemesViewController: ThemesViewDelegate {
    
    func themeViewTapped() {
        updateTheme()
        onCompletion?()
    }
}
