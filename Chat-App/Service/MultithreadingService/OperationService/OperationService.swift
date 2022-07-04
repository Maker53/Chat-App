//
//  OperationService.swift
//  Chat-App
//
//  Created by Станислав on 03.07.2022.
//

import Foundation

class OperationService: MultithreadingService {
    
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
