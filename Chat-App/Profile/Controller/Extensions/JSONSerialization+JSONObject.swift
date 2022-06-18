//
//  JSONSerialization+JSONObject.swift
//  Chat-App
//
//  Created by Станислав on 15.06.2022.
//

import Foundation

extension JSONSerialization {
    static func fetchObject<T: Decodable>(withFileName fileName: String, type: T.Type) throws -> T? {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        if let path = urls.first {
            var fileURL = path.appendingPathComponent(fileName)
            fileURL.appendPathExtension("json")
            
            let data = try Data(contentsOf: fileURL)
            let object = try JSONDecoder().decode(type, from: data)
            return object
        }
        
        return nil
    }
    
    static func saveObject<T: Encodable>(_ object: T, withFileName fileName: String) throws -> Bool {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        if let path = urls.first {
            var fileUrl = path.appendingPathComponent(fileName)
            fileUrl.appendPathExtension("json")
            
            let data = try JSONEncoder().encode(object)

            try data.write(to: fileUrl, options: [.atomic])
            
            return true
        }
        
        return false
    }
}
