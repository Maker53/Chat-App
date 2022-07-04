//
//  ConversationViewController.swift
//  Chat-App
//
//  Created by Станислав on 08.03.2022.
//

import UIKit
import CoreData

class ConversationViewController: UIViewController {
    
    // MARK: - Visual Components
    
    var mainView: ConversationView? {
        view as? ConversationView
    }
    
    // MARK: - Public Properties
    
    var channel: Channel!
    
    // MARK: - Services
    
    private let fetchControllerService: FetchControllerService!
    private let themeService: ThemeService!
    private let firebaseService: MessageFirebaseService!
    private let tableViewDataSource: ConversationTableViewDataSource!
    
    // MARK: - Private Properties
    
    private let fetchController: NSFetchedResultsController<MessageDB>?
    
    // MARK: - Initializers
    
    init(channel: Channel) {
        self.channel = channel
        self.fetchControllerService = ServiceAssembly.fetchControllerService
        self.themeService = ServiceAssembly.themeService
        self.firebaseService = ServiceAssembly.messageFirebaseService
        
        let format = #keyPath(MessageDB.channel.identifier) + " == %@"
        let predicate = NSPredicate(format: format, channel.identifier)
        let sortDescriptor = [NSSortDescriptor(key: #keyPath(MessageDB.created), ascending: true)]
        fetchController = fetchControllerService.createFetchController(withSortDescriptor: sortDescriptor, andPredicate: predicate)
        
        self.tableViewDataSource = ConversationTableViewDataSource(
            fetchController: fetchController,
            themeDesign: themeService.getCurrentThemeDesign())
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    
    override func loadView() {        
        view = ConversationView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView?.tableView.dataSource = tableViewDataSource
        mainView?.delegate = self
        tableViewDataSource.fetchController?.delegate = self
        
        try? tableViewDataSource.fetchController?.performFetch()
        
        firebaseService.listeningMessages(fromChannel: channel)
        hideKeyboardWhenTappedAround()
        updateTheme()
    }
}

// MARK: - Private Methods

extension ConversationViewController {
    
    private func updateTheme() {
        let themeDesign = themeService.getCurrentThemeDesign()
        
        mainView?.backgroundColor = themeDesign.backgroundColor
        mainView?.backgroundView.backgroundColor = themeDesign.backgroundColor
    }
}

// MARK: - ConversationViewDelegate

extension ConversationViewController: ConversationViewDelegate {
    
    func sendMessage(_ content: String) {
        firebaseService.createMessage(withContent: content, byChannel: channel)
    }
}
