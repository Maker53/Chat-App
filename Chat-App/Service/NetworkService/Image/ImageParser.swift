//
//  ImageParser.swift
//  Chat-App
//
//  Created by Станислав on 06.07.2022.
//

import UIKit

class ImageParser: Parser {
    
    typealias Model = UIImage
    
    func parse(data: Data) -> UIImage? {
        UIImage(data: data)
    }
}
