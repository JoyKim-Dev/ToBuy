//
//  TabBarController.swift
//  ToBuy
//
//  Created by Joy Kim on 6/13/24.
//

import UIKit

final class TabBarController: UITabBarController {
  
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = Color.orange
        tabBar.unselectedItemTintColor = Color.darkGray
        
        
       let searchVC =  UINavigationController(rootViewController: SearchMainVC())
        searchVC.tabBarItem = UITabBarItem(title: "검색", image: Icon.search, tag: 0)
        
        let settingVC = UINavigationController(rootViewController: SettingMainVC())
        settingVC.tabBarItem = UITabBarItem(title: "설정", image: Icon.person, tag: 1)
        
        let likedVC = UINavigationController(rootViewController: LikedItemViewController())
        likedVC.tabBarItem = UITabBarItem(title: "찜", image: Icon.likeUnSelected, tag: 2)

        setViewControllers([searchVC, likedVC, settingVC], animated: true)
    }
}
