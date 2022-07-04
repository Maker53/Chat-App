//
//  StorageServiceImplementation.swift
//  Chat-App
//
//  Created by Станислав on 03.07.2022.
//

import Foundation

class StorageServiceImplementation: StorageService {
    
    func fetchObject<T: Decodable>(withFileName fileName: String, type: T.Type) throws -> T? {
        if let fileURL = getFileURL(byFileName: fileName) {
            let data = try Data(contentsOf: fileURL)
            let object = try JSONDecoder().decode(type, from: data)
            
            return object
        }
        
        return nil
    }
    
    func saveObject<T: Encodable>(_ object: T, withFileName fileName: String) throws -> Bool {
        if let fileURL = getFileURL(byFileName: fileName) {
            let data = try JSONEncoder().encode(object)
            
            try data.write(to: fileURL, options: [.atomic])
            
            return true
        }
        
        return false
    }
    
    private func getFileURL(byFileName fileName: String) -> URL? {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        if let path = urls.first {
            var fileURL = path.appendingPathComponent(fileName)
            
            fileURL.appendPathExtension("json")
            
            return fileURL
        }
        
        return nil
    }
}
