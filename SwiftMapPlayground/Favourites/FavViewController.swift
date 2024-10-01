//
//  FavViewController.swift
//  SwiftMapPlayground
//
//  Created by Swan Nay Phue Aung on 01/10/2024.
//

import UIKit

class FavViewController: UIViewController {

    
    
    
    private var favourites : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.tintColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Favourites"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(favourites)
        view.addSubview(tableView)
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavCell.self, forCellReuseIdentifier: FavCell.cellIdentifier)
        setUpUI()
        let favAlbums = retrieveSavedAlbums()
        print("favAlbums: \(favAlbums)")
        
        
        
    }
    
    fileprivate func setUpUI(){
        NSLayoutConstraint.activate([
        
            favourites.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 12),
            favourites.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 12),
            
            tableView.topAnchor.constraint(equalTo: favourites.bottomAnchor,constant: 12),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 12),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -12),
           tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        
        
        ])
    }
    
}



extension FavViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let favAlbums = retrieveSavedAlbums()
        return favAlbums.count
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favAlbums = retrieveSavedAlbums()
        let cell = tableView.dequeueReusableCell(withIdentifier: FavCell.cellIdentifier, for: indexPath) as! FavCell
         let albums = favAlbums[indexPath.row]
        cell.configure(album: albums)
        return cell
        
    }
    
   
    
    
    private func retrieveSavedAlbums() -> [AlbumModel] {
        let defaults = UserDefaults.standard
        if let savedData = defaults.data(forKey: "selectedAlbums"),
           let savedAlbums = try? JSONDecoder().decode([AlbumModel].self, from: savedData) {
            return savedAlbums
        }
        return []
    }
 
}

