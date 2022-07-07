//
//  ImageListParser.swift
//  Chat-App
//
//  Created by Станислав on 05.07.2022.
//

import Foundation

class ImageListParser: Parser {
    
    typealias Model = [Picture]
    
    func parse(data: Data) -> [Picture]? {
        try? JSONDecoder().decode(Model.self, from: data)
    }
}
