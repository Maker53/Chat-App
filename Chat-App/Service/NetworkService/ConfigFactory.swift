//
//  ConfigFactory.swift
//  Chat-App
//
//  Created by Станислав on 06.07.2022.
//

struct ConfigFactory {
    
    var imageListConfig: RequestConfig<ImageListParser> {
        .init(request: ImageListRequest(), parser: ImageListParser())
    }
    
    func imageConfig(stringURL: String) -> RequestConfig<ImageParser> {
        .init(request: ImageRequest(stringURL: stringURL), parser: ImageParser())
    }
}
