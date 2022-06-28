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
    
    private var mainView: ConversationsListView? {
        view as? ConversationsListView
    }
    
    // MARK: - Public Properties
    
    let displayData = ConversationsListDisplayDataParser()
    lazy var fetchController: NSFetchedResultsController<ChannelDB> = {
        let context = CoreDataService.shared.coreDataStack.readContext
        let fetchRequest = ChannelDB.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: #keyPath(ChannelDB.lastActivity), ascending: false)
        ]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: context,
                                                    sectionNameKeyPath: nil,
                                                    cacheName: nil)
        
        controller.delegate = self
        
        do {
            try controller.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        
        return controller
    }()
    
    // MARK: - Override Methods
    
    override func loadView() {
        view = ConversationsListView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Channels"
        
        mainView?.tableView.delegate = self
        mainView?.tableView.dataSource = self
        
        FirebaseService.shared.getChannels()
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
        
        themesViewController.onComplition = { [unowned self] in
            self.updateTheme()
        }
        
        navigationController?.pushViewController(themesViewController, animated: true)
    }
    
    @objc private func profileButtonPressed() {
        let userName = StorageManager.fetchObjectFromFile().name
        let profileViewController = ProfileViewController()
        let navigationController = UINavigationController(rootViewController: profileViewController)
        
        profileViewController.title = userName
        navigationController.navigationBar.prefersLargeTitles = true
        
        present(navigationController, animated: true)
    }
    
    @objc private func newChannelButtonPressed() {
        let alert = UIAlertController(title: "Add new channel", message: "Enter channel name", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let createAction = UIAlertAction(title: "Create", style: .default) { _ in
            if let channelName = alert.textFields?.first?.text {
                FirebaseService.shared.addChannel(withName: channelName)
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

// MARK: - NSFetchedResultsControllerDelegate

extension ConversationsListViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        mainView?.tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        mainView?.tableView.endUpdates()
    }
    
    func controller(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>,
        didChange anObject: Any, at indexPath: IndexPath?,
        for type: NSFetchedResultsChangeType,
        newIndexPath: IndexPath?
    ) {
        
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            
            mainView?.tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            
            mainView?.tableView.deleteRows(at: [indexPath], with: .automatic)
        case .move:
            guard let newIndexPath = newIndexPath else { return }
            guard let indexPath = indexPath else { return }
            
            mainView?.tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else { return }
            
            mainView?.tableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            return
        }
    }
}

// MARK: - ThemeServiceDelegate

extension ConversationsListViewController: ThemeServiceDelegate {
    
    func updateTheme() {
        let themeDesign = ThemeService().getCurrentThemeDesign()
                
        navigationController?.navigationBar.barTintColor = themeDesign.navigationBarColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: themeDesign.titleColor]
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: themeDesign.titleColor]
        
        UITableView.appearance().backgroundColor = themeDesign.backgroundColor
        UITableViewCell.appearance().backgroundColor = themeDesign.backgroundColor
        
        UILabel.appearance().textColor = themeDesign.labelColor
        
        UITextView.appearance().textColor = themeDesign.labelColor
        UITextView.appearance().backgroundColor = themeDesign.backgroundColor
    }
}
