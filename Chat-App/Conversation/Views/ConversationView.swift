//
//  ConversationView.swift
//  Chat-App
//
//  Created by Станислав on 12.06.2022.
//

import UIKit

class ConversationView: UIView {
    // MARK: - Visual Components
    private var backgroundViewBottomConstraint: NSLayoutConstraint?
    private var messageTextViewHeightConstraint: NSLayoutConstraint?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 62
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            UINib(nibName: "OutgoingMessageCell", bundle: nil),
            forCellReuseIdentifier: MessageCell.identifierForOutgoingCell
        )
        tableView.register(
            UINib(nibName: "IncomingMessageCell", bundle: nil),
            forCellReuseIdentifier: MessageCell.identifierForIncomingCell
        )
        
        return tableView
    }()
    
    lazy var messageTextView: UITextView = {
        let textView = UITextView()
        
        textView.isScrollEnabled = false
        textView.font = .systemFont(ofSize: 18)
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.systemGray3.cgColor
        textView.layer.cornerRadius = 10
        textView.showsHorizontalScrollIndicator = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    lazy var sendMessageButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "arrow.up")
        
        button.setImage(image, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var backgroundView: UIView = {
       let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // MARK: - Private Properties
    private var maxTextViewHeight = UIScreen.main.bounds.width / 4
    private var isOversized = false {
        didSet {
            messageTextView.isScrollEnabled = isOversized
            // TODO: scroll table view to bottom
        }
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        messageTextView.delegate = self
        
        addSubviews()
        setupKeyboardObservers()
        setupConstraints()
        textViewDidChange(messageTextView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods
extension ConversationView {
    private func addSubviews() {
        addSubview(tableView)
        addSubview(backgroundView)
        backgroundView.addSubview(messageTextView)
        backgroundView.addSubview(sendMessageButton)
    }
    
    private func setupConstraints() {
        var constraints: [NSLayoutConstraint] = []
        
        let tableViewConstraints = [
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: backgroundView.topAnchor)
        ]
        
        let backgroundViewConstraints = [
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        
        backgroundViewBottomConstraint = backgroundView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        backgroundViewBottomConstraint?.isActive = true
        
        let messageTextViewConstraints = [
            messageTextView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 10),
            messageTextView.trailingAnchor.constraint(equalTo: sendMessageButton.leadingAnchor, constant: -10),
            messageTextView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -10),
            messageTextView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 10)
        ]
        
        messageTextViewHeightConstraint = messageTextView.heightAnchor.constraint(equalToConstant: 0)
        messageTextViewHeightConstraint?.isActive = true
        
        let sendButtonConstraints = [
            sendMessageButton.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 10),
            sendMessageButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -10),
            sendMessageButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -10)
        ]
        
        sendMessageButton.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        constraints.append(contentsOf: tableViewConstraints)
        constraints.append(contentsOf: backgroundViewConstraints)
        constraints.append(contentsOf: messageTextViewConstraints)
        constraints.append(contentsOf: sendButtonConstraints)
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(keyboardNotification), name: UIWindow.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardNotification), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - UITextViewDelegate
extension ConversationView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.contentSize.height < maxTextViewHeight {
            let size = CGSize(width: frame.width, height: .infinity)
            let estimatedSize = textView.sizeThatFits(size)
            
            messageTextViewHeightConstraint?.constant = estimatedSize.height
            isOversized = false
        } else {
            isOversized = true
        }
        
        sendMessageButton.isEnabled = !textView.text.isBlank
    }
}

// MARK: - Keyboard Notifications
extension ConversationView {
    @objc private func keyboardNotification(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let isKeyboardShowing = notification.name == UIWindow.keyboardWillShowNotification
        let keyboardHeight = keyboardFrame.cgRectValue.height
        
        backgroundViewBottomConstraint?.constant = isKeyboardShowing ? -keyboardHeight + safeAreaInsets.bottom : 0
    }
}

// MARK: - Button Action
extension ConversationView {
    @objc private func sendButtonTapped() {
        
    }
}
