//
//  Parser.swift
//  Chat-App
//
//  Created by Станислав on 05.07.2022.
//

import Foundation

protocol Parser {
    
    associatedtype Model
    func parse(data: Data) -> Model?
}
