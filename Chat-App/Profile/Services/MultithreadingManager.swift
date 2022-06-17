//
//  MultithreadingManager.swift
//  Chat-App
//
//  Created by Станислав on 16.06.2022.
//

import Foundation

protocol MultithreadingManager {
    func saveData(_ data: UserProfileInfo, completion: @escaping (Bool) -> Void)
    func fetchData(completion: @escaping (UserProfileInfo) -> Void)
}

extension MultithreadingManager {
    func fetchData(completion: @escaping (UserProfileInfo) -> Void) { }
}
