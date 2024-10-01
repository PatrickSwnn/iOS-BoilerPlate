//
//  CollectionViewController.swift
//  SwiftMapPlayground
//
//  Created by Swan Nay Phue Aung on 01/10/2024.
//

import Foundation
import UIKit

class CollectionViewController : UIViewController {
    
    private var albumsVM = AlbumViewModel()

    
    
    
    private var postHeading : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.tintColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Album"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        //for vertical scroll
//        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.reloadData()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AlbumCell.self, forCellWithReuseIdentifier: AlbumCell.albumCellIdentifier)
        setUpUI()
        setUpConstrains()

    }
    

    
    fileprivate func setUpUI() {
        view.addSubview(postHeading)
        view.addSubview(collectionView)
    }
    
    
    
    fileprivate func setUpConstrains() {
        NSLayoutConstraint.activate([
        
            postHeading.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            postHeading.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            
            collectionView.topAnchor.constraint(equalTo: postHeading.bottomAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 220),
            
          

        
        
        ])
    }
    
}


extension CollectionViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumsVM.albums?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCell.albumCellIdentifier, for: indexPath) as! AlbumCell
        guard let album = albumsVM.albums else { return cell }
        cell.configure(album: album[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = AlbumDetailViewController()
        if let album = albumsVM.albums?[indexPath.row] {
            detailVC.configure(album: album)
            navigationController?.pushViewController(detailVC, animated: true)
    }
}
    
}

    

