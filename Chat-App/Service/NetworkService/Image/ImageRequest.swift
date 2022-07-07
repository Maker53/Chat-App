//
//  ImageRequest.swift
//  Chat-App
//
//  Created by Станислав on 06.07.2022.
//

import Foundation

class ImageRequest: Request {
    
    var urlRequest: URLRequest?
    
    init(stringURL: String) {
        guard let url = URL(string: stringURL) else { return }
        self.urlRequest = URLRequest(url: url)
    }
}
