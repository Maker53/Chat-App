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
        view.backgroundColor = .systemBackground
        navigationItem.hidesBackButton = true
        title = "Settings"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelBarButtonPressed)
        )
        
        let colorForClassicIncomingMessage = #colorLiteral(red: 0.8352822661, green: 0.9767181277, blue: 0.753190279, alpha: 1)
        classicThemeButton = createThemeButton(
            outgoingMessageColor: colorForClassicIncomingMessage,
            incomingMessageColor: .systemGray4,
            backgroundColor: .systemBackground
        )

        dayThemeButton = createThemeButton(
            outgoingMessageColor: .systemBlue,
            incomingMessageColor: .systemGray5,
            backgroundColor: .systemBackground
        )

        nightThemeButton = createThemeButton(
            outgoingMessageColor: .systemGray,
            incomingMessageColor: .darkGray,
            backgroundColor: .black
        )

        let classicButtonLabel = createLabel(with: "Classic")
        let dayButtonLabel = createLabel(with: "Day")
        let nightButtonLabel = createLabel(with: "Night")
        
        let classicStackView = createStackView(with: classicThemeButton, and: classicButtonLabel)
        let dayStackView = createStackView(with: dayThemeButton, and: dayButtonLabel)
        let nightStackView = createStackView(with: nightThemeButton, and: nightButtonLabel)
        
        classicStackView.tag = 0
        dayStackView.tag = 1
        nightStackView.tag = 2
        
        let stackView = UIStackView(arrangedSubviews: [
            classicStackView, dayStackView, nightStackView
        ])
        
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
    
    // MARK: - Create theme button
    private func createThemeButton(outgoingMessageColor: UIColor, incomingMessageColor: UIColor, backgroundColor: UIColor) -> UIButton {
        let button: UIButton = {
            let button = UIButton()
            button.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 0.75)
            button.layer.cornerRadius = 15
            button.layer.borderWidth = 1
            button.isUserInteractionEnabled = false
                                    
            return button
        }()
        
        let view: UIView = {
            let view = UIView()
            view.backgroundColor = backgroundColor
            view.layer.cornerRadius = 15
            view.isUserInteractionEnabled = false
            
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
        
        return button
    }
    
    // MARK: - Create label
    private func createLabel(with title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.textAlignment = .center
        let huggingPriority = label.contentHuggingPriority(for: .vertical) + 1
        label.setContentHuggingPriority(huggingPriority, for: .vertical)
        
        return label
    }
    
    // MARK: - Create button with label stack view
    func createStackView(with button: UIButton, and label: UILabel) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [button, label])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(changeThemeButtonPressed))
        stackView.addGestureRecognizer(tap)
        stackView.isUserInteractionEnabled = true
        
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
