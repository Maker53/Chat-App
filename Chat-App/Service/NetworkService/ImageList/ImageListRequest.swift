//
//  ImageListRequest.swift
//  Chat-App
//
//  Created by Станислав on 06.07.2022.
//

import Foundation

class ImageListRequest: Request {
    
    var urlRequest: URLRequest? = {
        let requestCount = 30
        let stringURL = "https://api.unsplash.com/photos/random/?client_id=\(Constants.apiKeyForProfileImageList)&count=\(requestCount)"
        guard let url = URL(string: stringURL) else { return nil }
        let request = URLRequest(url: url)
        
        return request
    }()
}
