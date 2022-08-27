//
//  ConversationsListViewController.swift
//  Chat-App
//
//  Created by Станислав on 07.03.2022.
//

import UIKit
import CoreData

class ConversationsListViewController: UIViewController {
    
    // MARK: - UI
    
    var mainView: ConversationsListView? {
        view as? ConversationsListView
    }

    // MARK: - Services
    
    private let fetchControllerService: FetchControllerService!
    private let firebaseService: ChannelFirebaseService!
    private let themeService: ThemeService!
    private let tableViewDataSource: ConversationsListTableViewDataSource!
    private let tableViewDelegate: ConversationsListTableViewDelegate!
    private lazy var profileDataService = ServiceAssembly.profileDataService
    
    // MARK: - Private Properties
    
    private let fetchController: NSFetchedResultsController<ChannelDB>?
    
    // MARK: - Initializers
    
    init() {
        self.fetchControllerService = ServiceAssembly.fetchControllerService
        self.firebaseService = ServiceAssembly.channelFirebaseService
        self.themeService = ServiceAssembly.themeService
        
        let sortDescriptor = [NSSortDescriptor(key: #keyPath(ChannelDB.lastActivity), ascending: false)]
        fetchController = fetchControllerService.createFetchController(withSortDescriptor: sortDescriptor, andPredicate: nil)
        
        self.tableViewDataSource = ConversationsListTableViewDataSource(fetchController: fetchController, firebaseService: firebaseService)
        self.tableViewDelegate = ConversationsListTableViewDelegate(fetchController: fetchController)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    
    override func loadView() {
        view = ConversationsListView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Channels"
        
        mainView?.tableView.delegate = tableViewDelegate
        mainView?.tableView.dataSource = tableViewDataSource
        tableViewDelegate.delegate = self
        tableViewDataSource.fetchController?.delegate = self
        
        try? tableViewDataSource.fetchController?.performFetch()
        
        firebaseService.listeningChannels()
        setupNavigationItems()
        updateTheme()
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
    
    private func updateTheme() {
        let themeDesign = themeService.getCurrentThemeDesign()
                
        navigationController?.navigationBar.barTintColor = themeDesign.navigationBarColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: themeDesign.titleColor]
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: themeDesign.titleColor]
        
        UITableView.appearance().backgroundColor = themeDesign.backgroundColor
        UITableViewCell.appearance().backgroundColor = themeDesign.backgroundColor
        
        UILabel.appearance().textColor = themeDesign.labelColor
        
        UITextView.appearance().textColor = themeDesign.labelColor
        UITextView.appearance().backgroundColor = themeDesign.backgroundColor
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
        
        themesViewController.onCompletion = { [unowned self] in
            self.updateTheme()
        }
        
        navigationController?.pushViewController(themesViewController, animated: true)
    }
    
    @objc private func profileButtonPressed() {
        let userName = profileDataService.fetchProfileFromFile().name
        let profileViewController = ProfileViewController()
        let navigationController = UINavigationController(rootViewController: profileViewController)
        
        profileViewController.title = userName
        navigationController.navigationBar.prefersLargeTitles = true
        
        present(navigationController, animated: true)
    }
    
    @objc private func newChannelButtonPressed() {
        let alert = UIAlertController(title: "Add new channel", message: "Enter channel name", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let createAction = UIAlertAction(title: "Create", style: .default) { [unowned self] _ in
            if let channelName = alert.textFields?.first?.text {
                self.firebaseService.createChannel(name: channelName)
            }
        }
        
        createAction.isEnabled = false
        
        alert.addTextField { textField in
            textField.placeholder = "Channel name"
            
            NotificationCenter.default.addObserver(
                forName: UITextField.textDidChangeNotification,
                object: textField,
                queue: OperationQueue.main) { _ in
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

// MARK: - ConversationsListTableViewNavigation

extension ConversationsListViewController: ConversationsListTableViewNavigation {
    
    func pushViewController(_ controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
}
