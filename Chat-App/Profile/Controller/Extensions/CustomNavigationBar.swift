//
//  CustomNavigationBar.swift
//  Chat-App
//
//  Created by Станислав on 07.03.2022.
//

import UIKit

extension ProfileViewController {
    func createCustomNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationController?.navigationBar.prefersLargeTitles = true
        title = ""
    }
    
    func createCustomTitleView() -> UIView {
        let view = UIView()
        view.frame = CGRect(
            x: 0,
            y: 0,
            width: navigationController?.navigationBar.frame.width ?? 0,
            height: navigationController?.navigationBar.frame.height ?? 0
        )
        
        let titleLabel = UILabel()
        titleLabel.text = "My Profile"
        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        
        titleLabel.frame = CGRect(
            x: 16,
            y: view.center.y - 12,
            width: 115,
            height: 24
        )
        view.addSubview(titleLabel)
        
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        
        button.frame = CGRect(x: view.frame.width - 65, y: view.center.y - 18, width: 50, height: 36)
        
        button.addTarget(self, action: #selector(closeBarButtonPressed), for: .touchUpInside)
        view.addSubview(button)
        
        return view
    }
}
