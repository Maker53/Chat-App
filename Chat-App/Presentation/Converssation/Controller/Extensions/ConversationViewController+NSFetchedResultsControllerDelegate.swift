//
//  ConversationViewController+NSFetchedResultsControllerDelegate.swift
//  Chat-App
//
//  Created by Станислав on 04.07.2022.
//

import CoreData

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
