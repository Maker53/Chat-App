//
//  ProfileImagePickerViewController.swift
//  Chat-App
//
//  Created by Станислав on 05.07.2022.
//

import UIKit

class ProfileImagePickerViewController: UIViewController {
    
    // MARK: - UI
    
    var mainView: ProfileImagePickerView? {
        view as? ProfileImagePickerView
    }
    
    // MARK: - Public Properties
    
    let collectionViewDataSource: ProfileImagePickerCollectionViewDataSource
    lazy var loadingReusableView = LoadingReusableView()
    var onCompletion: ((UIImage) -> Void)?
    
    // MARK: - Private Properties
    
    private let networkConfigFactory: ConfigFactory
    private let requestService: RequestSender
    private let collectionViewDelegate: ProfileImagePickerCollectionViewDelegate
    
    // MARK: - Initializers
    
    init() {
        networkConfigFactory = ServiceAssembly.networkConfigFactory
        requestService = CoreAssembly.requestService
        
        collectionViewDataSource = ProfileImagePickerCollectionViewDataSource(networkConfigFactory: networkConfigFactory, requestService: requestService)
        collectionViewDelegate = ProfileImagePickerCollectionViewDelegate()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    
    override func loadView() {
        view = ProfileImagePickerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView?.collectionView.dataSource = collectionViewDataSource
        mainView?.collectionView.delegate = collectionViewDelegate
        
        collectionViewDataSource.collectionViewController = self
        collectionViewDelegate.collectionViewController = self
        
        fetchImageList()
    }
    
    func fetchImageList() {
        let config = networkConfigFactory.imageListConfig
        requestService.send(config: config) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                var indexPaths: [IndexPath] = []
                let startIndex = self.collectionViewDataSource.imageURLs.count - 1
                let endIndex = startIndex + data.count
                
                for index in startIndex...endIndex {
                    let indexPath = IndexPath(row: index, section: 0)
                    indexPaths.append(indexPath)
                }
                
                self.collectionViewDataSource.imageURLs += data
                self.collectionViewDelegate.imageURLs += data
                
                DispatchQueue.main.async {
                    self.mainView?.collectionView.reloadItems(at: indexPaths)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
