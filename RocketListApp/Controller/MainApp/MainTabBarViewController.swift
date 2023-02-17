//
//  MainTabBarViewController.swift
//  RocketListApp
//
//  Created by nur kholis on 11/02/23.
//

import UIKit

class MainTabBarViewController: UITabBarController {

  let rocketsVC = UINavigationController(rootViewController: RocketViewController() )
  let profileVC = UINavigationController(rootViewController: ProfilViewController())

  override func viewDidLoad() {
      super.viewDidLoad()
      configureTabBar()
      configureUITabBarItems()
  }

  func configureUITabBarItems(){
    rocketsVC.tabBarItem = UITabBarItem(title: "Rocket List", image: SFSymbols.rocketSymbol, tag: 0)
    profileVC.tabBarItem = UITabBarItem(title: "Profile", image:  SFSymbols.profileSymbol, tag: 1)
  }

  func configureTabBar(){
    self.tabBar.barTintColor = UIColor.gray
    setViewControllers([rocketsVC, profileVC], animated: true)
  }
}
