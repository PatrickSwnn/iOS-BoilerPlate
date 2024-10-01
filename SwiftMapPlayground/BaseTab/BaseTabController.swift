//
//  BaseTabController.swift
//  ThaiLearn
//
//  Created by Swan Nay Phue Aung on 23/08/2024.
//

import UIKit

class BaseTabController: UITabBarController {

    

    
  
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedIndex = 0
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = false
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .white
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
            
        
        let mapVC = MapViewController()
        mapVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "map"), selectedImage: nil)
            
            
        let tableView = PostViewController()
        tableView.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "tablecells" ), selectedImage: nil)
            
            let collectionView = CollectionViewController()
        collectionView.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "doc.plaintext"), selectedImage: nil)
            
            
        let favView = FavViewController()
        favView.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "heart"), selectedImage: nil)
        
            let mapNavigation = UINavigationController(rootViewController: mapVC )
            let tableNavigation = UINavigationController(rootViewController: tableView )
            let collectionNavigation = UINavigationController(rootViewController: collectionView)
        let favNavigation = UINavigationController(rootViewController: favView)

            
            viewControllers = [mapNavigation,tableNavigation,collectionNavigation,favNavigation]
            
        }
    
    


}
