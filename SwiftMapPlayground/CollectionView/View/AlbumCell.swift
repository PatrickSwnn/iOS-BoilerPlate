//
//  AlbumCell.swift
//  SwiftMapPlayground
//
//  Created by Swan Nay Phue Aung on 01/10/2024.
//

import UIKit
import Foundation

class AlbumCell:  UICollectionViewCell {
    
    //MARK: - Variables
      private var album : AlbumModel?
    static let albumCellIdentifier = "AlbumCell"
      
      //MARK: - UI Components
      private var albumImage : UIImageView = {
         let albumImage = UIImageView()
          albumImage.clipsToBounds = true
          albumImage.backgroundColor = .blue
          albumImage.layer.cornerRadius = 15
          return albumImage
      }()
      
      private var title : UILabel = {
         let title = UILabel()
          title.translatesAutoresizingMaskIntoConstraints = false
          title.font = .systemFont(ofSize: 18, weight: .bold)
          title.numberOfLines = 2
          title.lineBreakMode = .byTruncatingTail
          return title
      }()
      
      //MARK: - Lifecycle Methods
      override init(frame: CGRect) {
          super.init(frame: frame)
          layer.cornerRadius = 20
          layer.shadowColor = UIColor.black.cgColor // Shadow color
          layer.shadowOpacity = 0.2
          layer.shadowOffset = CGSize(width: 0, height: 1) // Offset of the shadow
          layer.shadowRadius = 4
          
          backgroundColor = .white
          setUpUI()
          
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
      
      //MARK: - Data Receiver from Parent View
      public func configure(album : AlbumModel) {
          self.album = album
          //injecting model instance
          self.title.text = album.title
      }
      
    

      
      
      //MARK: - UI Set Up
      fileprivate func setUpUI() {
          
          
          
          let vStack = UIStackView(arrangedSubviews: [albumImage,title])
          vStack.axis = .vertical
          vStack.translatesAutoresizingMaskIntoConstraints = false
          
          addSubview(vStack)
          
          NSLayoutConstraint.activate([
          
              vStack.topAnchor.constraint(equalTo: topAnchor,constant: 8),
              vStack.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 8),
              vStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
              vStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
              
              albumImage.widthAnchor.constraint(equalToConstant: 164),
              albumImage.heightAnchor.constraint(equalToConstant: 120),
          ])
      }
      
      
      fileprivate func setUpConstraints() {
          
      }
}
