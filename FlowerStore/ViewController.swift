//
//  ViewController.swift
//  FlowerStore
//
//  Created by Ivan Borinschi on 10.02.2022.
//

import UIKit
import DSKit

open class ViewController: DSTabBarViewController {
    
    let store = StoreViewController()
    let aboutUs = AboutUsViewController()
    let contacts = ContactsViewController()
    let history = HistoryViewController()
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        store.tabBarItem.title = "Store"
        store.tabBarItem.image = UIImage(systemName: "bag.fill")
        
        aboutUs.tabBarItem.title = "About Us"
        aboutUs.tabBarItem.image = UIImage(systemName: "info.circle.fill")
        
        contacts.tabBarItem.title = "Contacts"
        contacts.tabBarItem.image = UIImage(systemName: "map.fill")
        
        history.tabBarItem.title = "History"
        history.tabBarItem.image = UIImage(systemName: "clock.fill")
        
        setViewControllers([DSNavigationViewController(rootViewController: store),
                            DSNavigationViewController(rootViewController: history),
                            DSNavigationViewController(rootViewController: aboutUs),
                            DSNavigationViewController(rootViewController: contacts)], animated: true)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
