//
//  ConversationsListViewController.swift
//  Chat-App
//
//  Created by Станислав on 07.03.2022.
//

import UIKit
import FirebaseFirestore

class ConversationsListViewController: UIViewController {
    // MARK: - UI
    private var mainView: ConversationsListView? {
        view as? ConversationsListView
    }
    
    // MARK: - Public Properties
    let displayData = ConversationsListDisplayDataParser()
    var channels: [Channel] = []
    
    // MARK: - Override Methods
    override func loadView() {
        view = ConversationsListView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Channels"
        
        mainView?.tableView.delegate = self
        mainView?.tableView.dataSource = self
        
        setupNavigationItems()
        
        FirebaseService.shared.getChannels { [unowned self] channels in
            self.channels = channels
            self.mainView?.tableView.reloadData()
        }
    }
}

// MARK: - Private Methods
extension ConversationsListViewController {
    private func setupNavigationItems() {
        let themeImage = UIImage(systemName: "paintbrush")
        let profileImage = UIImage(systemName: "person")
        
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonPressed))
        let themeButton = UIBarButtonItem(image: themeImage, style: .plain, target: self, action: #selector(themeButtonPressed))
        let profileButton = UIBarButtonItem(image: profileImage, style: .plain, target: self, action: #selector(profileButtonPressed))
        let createChannelButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(newChannelButtonPressed))
        
        navigationItem.leftBarButtonItems = [editButton, themeButton]
        navigationItem.rightBarButtonItems = [profileButton, createChannelButton]
    }
    
    // MARK: - Target Actions
    @objc private func editButtonPressed(_ sender: UIBarButtonItem) {
        guard let mainView = mainView else { return }
        
        if !mainView.tableView.isEditing {
            sender.style = .done
            sender.title = "Done"
            mainView.tableView.setEditing(true, animated: true)
        } else {
            sender.style = .plain
            sender.title = "Edit"
            mainView.tableView.setEditing(false, animated: true)
        }
    }
    
    @objc private func themeButtonPressed() {
        let themesViewController = ThemesViewController()
        navigationController?.pushViewController(themesViewController, animated: true)
    }
    
    @objc private func profileButtonPressed() {
        let profileViewController = ProfileViewController()
        let navigationController = UINavigationController(rootViewController: profileViewController)
        present(navigationController, animated: true)
    }
    
    @objc private func newChannelButtonPressed() {
        let alert = UIAlertController(title: "Add new channel", message: "Enter channel name", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let createAction = UIAlertAction(title: "Create", style: .default) { _ in
            let name = alert.textFields![0].text!
            FirebaseService.shared.addChannel(withName: name)
        }
        
        createAction.isEnabled = false
        
        alert.addTextField { textField in
            textField.placeholder = "Channel name"
            
            NotificationCenter.default.addObserver(
                forName: UITextField.textDidChangeNotification,
                object: textField,
                queue: OperationQueue.main)
            { _ in
                guard let inputText = textField.text else { return }
                let textIsNotEmpty = !inputText.isEmpty
                
                createAction.isEnabled = textIsNotEmpty
            }
        }
        
        alert.addAction(createAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}