//
//  MultithreadingService.swift
//  Chat-App
//
//  Created by Станислав on 03.07.2022.
//

protocol MultithreadingService {
    
    func saveData(_ data: UserProfileInfo, completion: @escaping (Bool) -> Void)
    func fetchData(completion: @escaping (UserProfileInfo) -> Void)
}

extension MultithreadingService {
    
    func fetchData(completion: @escaping (UserProfileInfo) -> Void) { }
}
