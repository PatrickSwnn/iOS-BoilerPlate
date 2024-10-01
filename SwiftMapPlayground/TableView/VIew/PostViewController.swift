//
//  TableViewController.swift
//  SwiftMapPlayground
//
//  Created by Swan Nay Phue Aung on 01/10/2024.
//

import Foundation
import UIKit

class PostViewController : UIViewController {
    
    private var postsVM = PostViewModel()
    
    //MARK: -UI Components
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.cellIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
    
    
    //MARK: -UI Set Up
    private func setUpUI() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        tableView.reloadData()
    }
    
}

extension PostViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsVM.posts?.count ?? 0
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.cellIdentifier, for: indexPath) as! PostCell
        guard let posts = postsVM.posts else { return cell }
        let postIndex = posts[indexPath.row]
        cell.configure(post: postIndex )
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        guard let posts = postsVM.posts?[indexPath.row] else { return  }
        detailVC.configure(post: posts)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}

