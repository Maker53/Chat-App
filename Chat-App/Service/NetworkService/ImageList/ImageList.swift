//
//  ImageList.swift
//  Chat-App
//
//  Created by Станислав on 05.07.2022.
//

struct Picture: Codable {
    
    let quality: Raw
    
    enum CodingKeys: String, CodingKey {
        case quality = "urls"
    }
}

struct Raw: Codable {
    
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "small_s3"
    }
}
