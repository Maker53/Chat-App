//
//  ViewController.swift
//  Chat-App
//
//  Created by Станислав on 19.02.2022.
//

import UIKit

// To enable / disable the display of the log in the console,
// refer to the public variable in the Constants file
// and assign it the appropriate value (true or false)

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        printLog()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        printLog()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        printLog()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        printLog()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        printLog()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        printLog()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        printLog()
    }
    
    // MARK: - Private Methods
    private func printLog(method: String = #function) {
        guard showLog else { return }
        
        print("Method: \(method)\n")
    }
}
