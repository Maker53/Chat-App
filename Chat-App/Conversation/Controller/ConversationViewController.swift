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
    lazy var displayDataParser = ConversationDisplayDataParser()
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_EN")
        dateFormatter.setLocalizedDateFormatFromTemplate("dd_MM HH_mm")
        
        return dateFormatter
    }()
    
    lazy var fetchController: NSFetchedResultsController<MessageDB> = {
        let context = CoreDataService.shared.coreDataStack.readContext
        let fetchRequest = MessageDB.fetchRequest()
        let format = #keyPath(MessageDB.channel.identifier) + " == %@"
        let predicate = NSPredicate(format: format, channel.identifier)
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(MessageDB.created), ascending: true)]
        fetchRequest.predicate = predicate
        
        let controller = NSFetchedResultsController(
            fetchRequest: fetchRequest,
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
        view = ConversationView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView?.tableView.dataSource = self
        mainView?.delegate = self
        
        FirebaseService.shared.getMessages(fromChannel: channel)
        hideKeyboardWhenTappedAround()
        updateTheme()
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension ConversationViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        mainView?.tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        mainView?.tableView.endUpdates()
        mainView?.tableView.scrollToBottom()
    }
    
    func controller(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>,
        didChange anObject: Any,
        at indexPath: IndexPath?,
        for type: NSFetchedResultsChangeType,
        newIndexPath: IndexPath?
    ) {
        if type == .insert {
            guard let newIndexPath = newIndexPath else { return }
            
            mainView?.tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
}

// MARK: - ConversationViewDelegate

extension ConversationViewController: ConversationViewDelegate {
    
    func sendMessage(_ content: String) {
        FirebaseService.shared.sendMessage(withContent: content, byPath: channel.identifier)
    }
}

// MARK: - ThemeServiceDelegate

extension ConversationViewController: ThemeServiceDelegate {
    
    func updateTheme() {
        let themeDesign = ThemeService().getCurrentThemeDesign()
        
        mainView?.backgroundColor = themeDesign.backgroundColor
        mainView?.backgroundView.backgroundColor = themeDesign.backgroundColor
    }
}
