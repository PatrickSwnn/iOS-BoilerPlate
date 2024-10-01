//
//  PostViewModel.swift
//  SwiftMapPlayground
//
//  Created by Swan Nay Phue Aung on 01/10/2024.
//

import Foundation

class PostViewModel {
    
    let apiManger = APIManager.shared
    private (set) var posts : [PostModel]? = [] {
        didSet {
            self.onPostsUpdate?()
        }
    }
    
    var onPostsUpdate: (()->Void)?
    
    init(){
        fetchPost()
    }
    
    private func fetchPost() {
        let url = "https://jsonplaceholder.typicode.com/posts"
        apiManger.fetchData(from: url, expecting: [PostModel].self) { result in
            
            switch result {
            case .success(let posts):
                self.posts = posts
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
    }
    
}
