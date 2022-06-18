//
//  ProfileView.swift
//  Chat-App
//
//  Created by Станислав on 08.06.2022.
//

import UIKit

protocol ProfileViewDelegate: AnyObject {
    func editImageButtonAction()
    func editButtonAction()
    func saveGCDButtonAction()
    func saveOperationButtonAction()
    func cancelButtonAction()
}
// TODO Добавить скролл вью и скролить при открытии клавиатуры, чтобы было видно что пишешь
class ProfileView: UIView {
    // MARK: - Visual Components
    
    lazy var userImageView: UIImageView = {
       let view = UIImageView()
        
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.backgroundColor = .systemYellow
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var initialsLabel: UILabel = {
       let label = UILabel()
        
        label.font = .systemFont(ofSize: 60, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var editImageButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Edit", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var userNameTextField: UITextField = {
       let field = UITextField()
        
        field.font = .systemFont(ofSize: 24, weight: .bold)
        field.attributedPlaceholder = NSAttributedString(
            string: "Full name",
            attributes: [.foregroundColor: UIColor.systemGray2])
        field.textAlignment = .center
        field.isEnabled = false
        field.translatesAutoresizingMaskIntoConstraints = false
        
        return field
    }()
    
    lazy var descriptionTextView: UITextView = {
       let textView = UITextView()
        
        textView.text = "About me"
        textView.font = .systemFont(ofSize: 16)
        textView.textAlignment = .center
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        
        indicator.style = .large
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        return indicator
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Edit", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 19, weight: .semibold)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGray5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var gcdButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Save GCD", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 19, weight: .semibold)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGray5
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var operationButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Save Operation", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 19, weight: .semibold)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGray5
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 19, weight: .semibold)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGray5
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - Public Properties
    
    weak var delegate: ProfileViewDelegate!
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        addTargets()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods

extension ProfileView {
    private func addSubviews() {
        addSubview(userImageView)
        userImageView.addSubview(initialsLabel)
        addSubview(editImageButton)
        addSubview(userNameTextField)
        addSubview(descriptionTextView)
        descriptionTextView.addSubview(activityIndicator)
        addSubview(editButton)
        addSubview(gcdButton)
        addSubview(operationButton)
        addSubview(cancelButton)
    }
    
    private func addTargets() {
        editImageButton.addTarget(self, action: #selector(editImageButtonAction), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        gcdButton.addTarget(self, action: #selector(saveGCDButtonTapped), for: .touchUpInside)
        operationButton.addTarget(self, action: #selector(saveOperationButtonTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            userImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            userImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 2 / 3),
            userImageView.heightAnchor.constraint(equalTo: userImageView.widthAnchor),
            
            initialsLabel.centerXAnchor.constraint(equalTo: userImageView.centerXAnchor),
            initialsLabel.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),
            
            editImageButton.centerXAnchor.constraint(equalTo: userImageView.rightAnchor),
            editImageButton.centerYAnchor.constraint(equalTo: userImageView.bottomAnchor),
            
            userNameTextField.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 20),
            userNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            userNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            descriptionTextView.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            
            activityIndicator.centerXAnchor.constraint(equalTo: descriptionTextView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: descriptionTextView.centerYAnchor),
            
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            editButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            editButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            gcdButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20),
            gcdButton.trailingAnchor.constraint(equalTo: cancelButton.centerXAnchor, constant: -10),
            gcdButton.leadingAnchor.constraint(equalTo: cancelButton.leadingAnchor),
            gcdButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -10),
            
            operationButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20),
            operationButton.leadingAnchor.constraint(equalTo: cancelButton.centerXAnchor, constant: 10),
            operationButton.trailingAnchor.constraint(equalTo: cancelButton.trailingAnchor),
            operationButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -10),
            
            cancelButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cancelButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    // MARK: - Target Actions
    
    @objc private func editImageButtonAction() {
        delegate.editImageButtonAction()
    }
    
    @objc private func editButtonTapped() {
        delegate.editButtonAction()
    }
    
    @objc private func saveGCDButtonTapped() {
        delegate.saveGCDButtonAction()
    }
    
    @objc private func saveOperationButtonTapped() {
        delegate.saveOperationButtonAction()
    }
    
    @objc private func cancelButtonAction() {
        delegate.cancelButtonAction()
    }
}
