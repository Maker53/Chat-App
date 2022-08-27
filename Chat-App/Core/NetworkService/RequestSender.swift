//
//  RequestSender.swift
//  Chat-App
//
//  Created by Станислав on 05.07.2022.
//

enum NetworkError: Error {
    
    case invalidURL
    case noData
    case parseError
}

protocol RequestSender {
    
    func send<T>(config: RequestConfig<T>, completion: @escaping (Result<T.Model, NetworkError>) -> Void)
}
