//
//  ViewController.swift
//  Download & cache images
//
//  Created by Виктор on 29.04.2020.
//  Copyright © 2020 Виктор. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
        
    let pullToRefresh = UIRefreshControl()
    
    var viewModel: ViewModelType!
            
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellId)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setupCollectionView()
        setupRefreshControl()
        viewModel.cellDataSource = viewModel.images
    }
    
    @objc func refresh() {
        viewModel.cellDataSource = viewModel.images
        CacheManager.shared.removeCache()
        collectionView.reloadData()
        self.pullToRefresh.endRefreshing()
    }
    
    func setupRefreshControl() {
        collectionView.addSubview(pullToRefresh)
        pullToRefresh.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    func setupCollectionView() {
        
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        if #available(iOS 11.0, *) {
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = Constants.collectionViewSectionInsets
        let cellWidthHeight: CGFloat = view.frame.width - Constants.cellSideFieldsInset
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Constants.lineSpacing
        layout.itemSize = CGSize(width: cellWidthHeight, height: cellWidthHeight)
        return layout
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numbersOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellId, for: indexPath) as? CollectionViewCell
        guard let collectionViewCell = cell, let viewModel = viewModel else { return UICollectionViewCell() }
        let cellViewModel = viewModel.cellViewModel(forIndexPAth: indexPath)
        collectionViewCell.set(cellviewModel: cellViewModel)
        return collectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3, animations: {
            (collectionView.cellForItem(at: indexPath))?.frame = ((collectionView.cellForItem(at: indexPath))?.frame.offsetBy(dx: 500, dy: 0))!
        })
        { (finished) in
            self.viewModel.cellDataSource.remove(at: indexPath.row)
            collectionView.cellForItem(at: indexPath)?.prepareForReuse()
                collectionView.deleteItems(at: [indexPath])
        }
    }
}
