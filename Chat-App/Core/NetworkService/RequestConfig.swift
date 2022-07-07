//
//  RequestConfig.swift
//  Chat-App
//
//  Created by Станислав on 05.07.2022.
//

struct RequestConfig<T: Parser> {
    
    let request: Request
    let parser: T
}
