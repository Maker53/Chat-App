//
//  OperationsManager.swift
//  Chat-App
//
//  Created by Станислав on 16.06.2022.
//

import Foundation

class OperationsManager: MultithreadingManager {
    func saveData(_ data: UserProfileInfo, completion: @escaping (Bool) -> Void) {
        let operationQueue = OperationQueue()
        let operation = SaveUserInfoOperation(object: data)
        operation.qualityOfService = .userInitiated

        operation.completionBlock = {
            OperationQueue.main.addOperation {
                completion(operation.isSaved)
            }
        }

        operationQueue.addOperation(operation)
    }
}
