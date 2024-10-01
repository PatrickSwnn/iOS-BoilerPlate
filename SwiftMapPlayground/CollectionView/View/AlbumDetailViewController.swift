
//
//  DetailViewController.swift
//  SwiftMapPlayground
//
//  Created by Swan Nay Phue Aung on 01/10/2024.
//

import UIKit

class AlbumDetailViewController: UIViewController {

    
    private var album : AlbumModel? = nil
    
    private var isSelected : Bool = false
    
    
    private let scrollView : UIScrollView = {
         let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
          return scrollView
      }()
      
      private let contentView : UIView = {
          let contentView = UIView()
          contentView.translatesAutoresizingMaskIntoConstraints = false
          return contentView
      }()
    
   
    
    private var albumTitle : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.tintColor = .gray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Unknown"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    
    private var button : UIButton = {
       let button = UIButton()
        button.tintColor = UIColor.systemPink
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .lightGray // Temporary color for debugging
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(heartTapped), for: .touchUpInside)
        return button
    }()
     
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpUI()
        checkIfAlbumIsSaved()
        updateHeartState()
       
    }
    
    
    public func configure(album : AlbumModel) {
        self.album  = album
        self.albumTitle.text = album.title
    }
    
    
    fileprivate func updateHeartState(){
        if isSelected {
            button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            button.setImage(UIImage(systemName: "heart"), for: .normal)

        }
    }
    
    
    
    fileprivate func setUpUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(albumTitle)
        contentView.addSubview(button)
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            //add this when the scroll is vertical
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            //add this when the scroll is horizontal
//            scrollView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
          
            
            albumTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            albumTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            albumTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            
    
            button.topAnchor.constraint(equalTo: albumTitle.bottomAnchor, constant: 8),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            button.heightAnchor.constraint(equalToConstant: 30),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    

    @objc private func heartTapped() {
        print("Button tapped")
        isSelected.toggle()
        updateHeartState()
        print(isSelected)
        
        if let album = album {
                   if isSelected {
                       saveAlbumToUserDefaults(album: album)
                   } else {
                       removeAlbumFromUserDefaults(album: album)
                   }
               }
    }
    
    private func saveAlbumToUserDefaults(album: AlbumModel) {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        
        // Fetch the current array of albums from UserDefaults
        if let savedData = defaults.data(forKey: "selectedAlbums"),
           var savedAlbums = try? JSONDecoder().decode([AlbumModel].self, from: savedData) {
            
            // Append the new album if it's not already saved
            if !savedAlbums.contains(where: { $0.id == album.id }) { // assuming AlbumModel has an `id`
                savedAlbums.append(album)
            }
            
            // Encode the updated array and save it back to UserDefaults
            if let encodedAlbums = try? encoder.encode(savedAlbums) {
                defaults.set(encodedAlbums, forKey: "selectedAlbums")
                print("Album added to UserDefaults: \(album)")
            }
            
        } else {
            // If no albums are saved yet, create a new array with the current album
            let newAlbumArray = [album]
            if let encodedAlbums = try? encoder.encode(newAlbumArray) {
                defaults.set(encodedAlbums, forKey: "selectedAlbums")
                print("First album saved to UserDefaults: \(album)")
            }
        }
    }


    private func removeAlbumFromUserDefaults(album: AlbumModel) {
        let defaults = UserDefaults.standard
        
        // Fetch the current array of albums from UserDefaults
        if let savedData = defaults.data(forKey: "selectedAlbums"),
           var savedAlbums = try? JSONDecoder().decode([AlbumModel].self, from: savedData) {
            
            // Remove the album by its id
            savedAlbums.removeAll(where: { $0.id == album.id }) // assuming AlbumModel has an `id`
            
            // Encode the updated array and save it back to UserDefaults
            let encoder = JSONEncoder()
            if let encodedAlbums = try? encoder.encode(savedAlbums) {
                defaults.set(encodedAlbums, forKey: "selectedAlbums")
                print("Album removed from UserDefaults: \(album)")
            }
            
        }
    }

    
    private func checkIfAlbumIsSaved() {
           guard let album = album else { return }

           let defaults = UserDefaults.standard
           if let savedData = defaults.data(forKey: "selectedAlbums"),
              let savedAlbums = try? JSONDecoder().decode([AlbumModel].self, from: savedData) {
               isSelected = savedAlbums.contains(where: { $0.id == album.id })
           }
       }

}
