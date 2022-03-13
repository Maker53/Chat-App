//
//  SetupThemesViewController.swift
//  Chat-App
//
//  Created by Станислав on 13.03.2022.
//

import UIKit

extension ThemesViewController {
    
    // MARK: - Setup Theme View Controller
    func setupThemeViewController() {
        view.backgroundColor = .systemGray5
        title = "Settings"
        
        let colorForClassicIncomingMessage = #colorLiteral(red: 0.8352822661, green: 0.9767181277, blue: 0.753190279, alpha: 1)
        let classicThemeButton = setupThemeButton(
            with: "Classic",
            outgoingMessageColor: colorForClassicIncomingMessage,
            incomingMessageColor: .systemGray4,
            backgroundColor: .systemBackground
        )
        
        let dayThemeButton = setupThemeButton(
            with: "Day",
            outgoingMessageColor: .systemBlue,
            incomingMessageColor: .systemGray5,
            backgroundColor: .systemBackground
        )
        
        let nightThemeButton = setupThemeButton(
            with: "Night",
            outgoingMessageColor: .systemGray,
            incomingMessageColor: .darkGray,
            backgroundColor: .black
        )
        
        let stackView = UIStackView(arrangedSubviews: [classicThemeButton, dayThemeButton, nightThemeButton])
        
        view.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 390),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32)
        ])
    }
    
    // MARK: - Setup theme button with label
    private func setupThemeButton(with label: String, outgoingMessageColor: UIColor, incomingMessageColor: UIColor, backgroundColor: UIColor) -> UIStackView {
        
        let button: UIButton = {
            let button = UIButton(frame: .zero)
            button.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 0.75)
            button.layer.cornerRadius = 15
            button.layer.borderWidth = 1
            
            return button
        }()
        
        let view: UIView = {
            let view = UIView()
            view.backgroundColor = backgroundColor
            view.layer.cornerRadius = 15
            
            return view
        }()
        
        let outgoingMessageView: UIView = {
            let view = UIView()
            view.backgroundColor = outgoingMessageColor
            view.layer.cornerRadius = 10
            
            return view
        }()
        
        let incomingMessageView: UIView = {
            let view = UIView()
            view.backgroundColor = incomingMessageColor
            view.layer.cornerRadius = 10
            
            return view
        }()
        
        let buttonLabel: UILabel = {
            let buttonLabel = UILabel()
            buttonLabel.text = label
            buttonLabel.textAlignment = .center
            let huggingPriority = buttonLabel.contentHuggingPriority(for: .vertical) + 1
            buttonLabel.setContentHuggingPriority(huggingPriority, for: .vertical)
            
            return buttonLabel
        }()
        
        view.addSubview(incomingMessageView)
        view.addSubview(outgoingMessageView)
        
        NSLayoutConstraint.activate([
            incomingMessageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25),
            incomingMessageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            incomingMessageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            incomingMessageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.41)
        ])
        
        incomingMessageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            outgoingMessageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            outgoingMessageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            outgoingMessageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            outgoingMessageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.41)
        ])
        
        outgoingMessageView.translatesAutoresizingMaskIntoConstraints = false
        
        button.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.bottomAnchor.constraint(equalTo: button.bottomAnchor),
            view.topAnchor.constraint(equalTo: button.topAnchor),
            view.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: button.trailingAnchor)
        ])
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [button, buttonLabel])
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
}

