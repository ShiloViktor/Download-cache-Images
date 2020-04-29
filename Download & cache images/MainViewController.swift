//
//  ViewController.swift
//  Download & cache images
//
//  Created by Виктор on 29.04.2020.
//  Copyright © 2020 Виктор. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    let pullToRefresh = UIRefreshControl()
    
    let webImageView = WebImageView()
    
    let imageUrls = ["https://s1.1zoom.me/b5050/995/Ocean_Island_Mountains_Sky_Mauritius_From_above_582975_800x600.jpg",
    "https://s1.1zoom.me/b5050/367/Mountains_Italy_Lake_Boats_Marinas_Lago_di_Braies_581849_800x600.jpg",
    "https://s1.1zoom.me/b5050/431/Russia_Crimea_Coast_Sea_Crag_Trees_581991_800x600.jpg",
    "https://s1.1zoom.me/b5050/680/Winter_Sky_Mountains_Snow_Night_Moon_Clouds_581802_800x600.jpg",
    "https://s1.1zoom.me/b5050/321/Pond_Sky_Pagodas_Temples_Japan_Kansai_Byodo-in_Uji_581333_800x600.jpg",
    "https://s1.1zoom.me/b5255/337/Roads_Sky_England_Scenery_Mam_Tor_Peak_District_580899_800x600.jpg"]
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        collectionView.addSubview(pullToRefresh)
        pullToRefresh.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc func refresh() {
//        webImageView.resetImages()
        webImageView.removeCache()
        collectionView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.pullToRefresh.endRefreshing()
        }
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let cellWidthHeight: CGFloat = view.frame.width - 20
        

        layout.sectionInset = UIEdgeInsets(top: 10,
                                           left: 0,
                                           bottom: 10,
                                           right: 0)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: cellWidthHeight, height: cellWidthHeight)
        
        return layout
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.imageViewCell.set(imageUrl: imageUrls, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5, animations: {
            (collectionView.cellForItem(at: indexPath))?.frame = ((collectionView.cellForItem(at: indexPath))?.frame.offsetBy(dx: 500, dy: 0))!
        })
        { (finished) in
            collectionView.cellForItem(at: indexPath)?.isHidden = true
            collectionView.performBatchUpdates({
                collectionView.deleteItems(at: [indexPath])
                collectionView.reloadData()
            }, completion: nil)
        }
    }
    
}
