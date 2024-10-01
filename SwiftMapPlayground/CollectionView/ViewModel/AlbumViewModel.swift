//
//  AlbumViewModekl.swift
//  SwiftMapPlayground
//
//  Created by Swan Nay Phue Aung on 01/10/2024.
//

import Foundation

class AlbumViewModel {
    
    let apiManger = APIManager.shared


    private (set) var albums : [AlbumModel]? = [] {
        didSet {
            self.onAlbumUpdate?()
        }
    }
    
    var onAlbumUpdate: (()->Void)?
    
    init(){
        fetchAlbum()
    }
    
    
    private func fetchAlbum() {
        let url = "https://jsonplaceholder.typicode.com/albums"
        apiManger.fetchData(from: url, expecting: [AlbumModel].self) { result in
            
            switch result {
            case .success(let albums):
                self.albums = albums
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
    }
    
    
    
}
