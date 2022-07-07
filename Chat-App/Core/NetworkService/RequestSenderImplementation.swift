//
//  RequestSenderImplementation.swift
//  Chat-App
//
//  Created by Станислав on 05.07.2022.
//

import Foundation

class RequestSenderImplementation: RequestSender {
    
    let session = URLSession.shared
    
    func send<T>(config: RequestConfig<T>, completion: @escaping (Result<T.Model, NetworkError>) -> Void) {
        guard let urlRequest = config.request.urlRequest else {
            completion(.failure(.invalidURL))
            return
        }
        
        session.dataTask(with: urlRequest) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }

            guard let parseModel = config.parser.parse(data: data) else {
                completion(.failure(.parseError))
                return
            }
            
            completion(.success(parseModel))
        }.resume()
    }
}
