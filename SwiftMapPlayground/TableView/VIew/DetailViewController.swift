//
//  DetailViewController.swift
//  SwiftMapPlayground
//
//  Created by Swan Nay Phue Aung on 01/10/2024.
//

import UIKit

class DetailViewController: UIViewController {

    
    private var post : PostModel? = nil
    
    
    
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
    
    private var postTitle : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.tintColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Unknown"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    
    private var postBody : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.tintColor = .gray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Unknown"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpUI()
       
    }
    
    
    public func configure(post : PostModel) {
        self.post = post
        self.postTitle.text = post.title
        self.postBody.text = post.body
    }
    
    fileprivate func setUpUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(postTitle)
        contentView.addSubview(postBody)
        
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
            
            
            postTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            postTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            postTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            postBody.topAnchor.constraint(equalTo: postTitle.bottomAnchor, constant: 8),
            postBody.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            postBody.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            postBody.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    


}
