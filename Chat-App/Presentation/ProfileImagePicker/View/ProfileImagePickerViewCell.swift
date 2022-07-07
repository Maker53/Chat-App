//
//  ProfileImagePickerViewCell.swift
//  Chat-App
//
//  Created by Станислав on 07.07.2022.
//

import UIKit

class ProfileImagePickerViewCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    var task: Task<(), Never>?
    
    // MARK: - UI
    
    var image: UIImage? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.imageView.image = self?.image
            }
        }
    }
    
    private var imageView: UIImageView = {
       let imageView = UIImageView()
        
        imageView.image = UIImage(named: "imagePlaceholder")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    
    override func prepareForReuse() {
        task?.cancel()
        task = nil
        
        image = UIImage(named: "imagePlaceholder")
        
        super.prepareForReuse()
    }
    
    // MARK: - Private Methods
    
    private func setupSubviews() {
        addSubview(imageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
