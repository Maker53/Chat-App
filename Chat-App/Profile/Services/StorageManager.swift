//
//  DataManager.swift
//  Chat-App
//
//  Created by Станислав on 22.03.2022.
//

import Foundation

class StorageManager {
    // MARK: - Singleton
    static let shared = StorageManager()
    
    // MARK: - Private Serial Queue
    let privateSerialQueue = DispatchQueue(label: "storageManagerQueue", qos: .utility)
    
    // MARK: - Private empty init
    private init() {}
    
    // MARK: - Save object
    func saveViaGCD(with object: UserProfileInfo, and fileName: String, notifyHandler completion: @escaping () -> ()) {
        let workItem = DispatchWorkItem {
            self.save(object, with: fileName)
        }
        
        privateSerialQueue.async(execute: workItem)
        
        workItem.notify(queue: .main) {
            completion()
        }
    }
    
    // MARK: - Fetch object
    func fetchViaGCD(from fileName: String, completion: @escaping (UserProfileInfo?) -> ()) {
        privateSerialQueue.async {
            let object = self.fetchObject(from: fileName)
            completion(object)
        }
    }
    
    // MARK: - Get Documents Directory
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // TODO: Подумать, как можно проверять объект, чтобы не перезаписывать повторяющиеся данные
    fileprivate func save(_ object: UserProfileInfo, with fileName: String) {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            let data = try JSONEncoder().encode(object)
            
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(atPath: url.path)
            }
            
            FileManager.default.createFile(atPath: url.path, contents: data)
        } catch {
            // TODO: Либо убрать, либо сообщить пользователю о неудаче
            print(error.localizedDescription)
        }
        print("storage - save!")
    }
    
    private func fetchObject(from fileName: String) -> UserProfileInfo? {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        
        if let data = FileManager.default.contents(atPath: url.path) {
            do {
                let model = try JSONDecoder().decode(UserProfileInfo.self, from: data)
                return model
            } catch {
                // TODO: Либо убрать, либо сообщить пользователю о неудаче
                print(error.localizedDescription)
            }
        } else {
            // TODO: Либо убрать, либо сообщить пользователю о неудаче
            print("No data at path \(url.path)")
        }
        return nil
    }
}

// MARK: - Save User Info Operation
class SaveUserInfoOperation: AsyncOperation {
    private var object: UserProfileInfo
    private var fileName: String
    
    init(object: UserProfileInfo, fileName: String) {
        self.object = object
        self.fileName = fileName
        super.init()
    }
    
    override func main() {
        asyncSaveUserInfo(object: object, fileName: fileName)
        state = .finished
    }
}

// MARK: - Async Operation
class AsyncOperation: Operation {
    enum State: String {
        case ready, executing, finished
        
        fileprivate var keyPath: String {
            return "is" + rawValue.capitalized
        }
    }
    
    var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
    
    func asyncSaveUserInfo(object: UserProfileInfo, fileName: String) {
        let saveQueue = OperationQueue()
        saveQueue.maxConcurrentOperationCount = 1
        
        saveQueue.addOperation {
            StorageManager.shared.save(object, with: fileName)
        }
    }
}

extension AsyncOperation {
    override var isReady: Bool {
        return super.isReady && state == .ready
    }
    
    override var isExecuting: Bool {
        return state == .executing
    }
    
    override var isFinished: Bool {
        return state == .finished
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override func start() {
        if isCancelled {
            state = .finished
            return
        }
        
        main()
        state = .executing
    }
    
    override func cancel() {
        super.cancel()
        state = .finished
    }
}
