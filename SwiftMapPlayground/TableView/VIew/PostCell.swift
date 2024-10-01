//
//  PostCell.swift
//  PokeAR
//
//  Created by Swan Nay Phue Aung on 17/08/2024.
//

import UIKit
import Foundation

class PostCell: UITableViewCell {
    
    //MARK: -Variables
    static let cellIdentifier = "PostCell"
    var post : PostModel? = nil
    
    //MARK: - UIComponents
    
    private var title : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.tintColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Unknown"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private var body : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.tintColor = .gray
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Unknown"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    
    
    //MARK: -Life Cycle Methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.contentView.backgroundColor = .clear
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init coder has not implemented ")
    }
    
    public func configure(post : PostModel) {
        self.post = post
        self.title.text = post.title
        self.body.text = post.body
    }
    
    
    
    
    //MARK: - Set up UI
    private func setUpUI() {
        contentView.addSubview(title)
        contentView.addSubview(body)

        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            body.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            body.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            body.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            body.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    
    
}

