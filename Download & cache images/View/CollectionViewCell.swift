//
//  CollectionViewCell.swift
//  Download & cache images
//
//  Created by Виктор on 29.04.2020.
//  Copyright © 2020 Виктор. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
        
    var imageViewCell: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.imageViewCell.image = nil
    }
    
    override func layoutSubviews() {
        setupUI()
    }
    
    func setupUI() {
        contentView.addSubview(imageViewCell)
        
        imageViewCell.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageViewCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        imageViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    func set(cellviewModel: CellViewModelType?) {
        guard let cellViewModel = cellviewModel else { return }
        
        NetworkManager.shared.downloadImage(imageUrl: cellViewModel.ImageUrl) { (image) in
            guard let image = image else { return }
            self.imageViewCell.image = image
        }
    }
}
