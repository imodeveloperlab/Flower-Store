//
//  OffersViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 28.01.2021.
//

import UIKit
import DSKit
import DSKitFakery

class RegionViewController: DSViewController {
    
    // Random data generator, an wrapper around https://github.com/vadymmarkov/Fakery
    let faker = DSFaker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Regions"
        update()
    }
    
    func update() {
        
        // Show regions
        show(content: [regionsSection()])
        
        // Show bottom button
        var button = DSButtonVM(title: "Done")
        button.didTap { [unowned self] (button :DSButtonVM) in
            self.pop()
        }
        
        showBottom(content: button)
    }
}

// MARK: - Regions Section
extension RegionViewController {
    
    func regionsSection() -> DSSection {
        
        var shops = faker.addresses.map { (address) -> DSViewModel in
            
            // Shop info
            let composer = DSTextComposer()
            composer.add(type: .headline, text: "Flower store")
            composer.add(type: .subheadline, text: address.address)
            
            // Right checkbox
            let isSelected = address.title == ShopManager.shared.deliveryLocation
            var action = composer.checkboxActionViewModel(selected: isSelected)
            
            // Left
            action.leftViewPosition = .center
            action.leftIcon(sfSymbolName: "house.fill", size: CGSize(width: 30, height: 30))
            
            // Set address as companion object
            action.object = address as AnyObject
            return action
        }
        
        // Handle did tap on shop
        shops = shops.didTap({ (shop: DSActionVM) in
            
            guard let address = shop.object as? DSAddress else {
                return
            }
            
            ShopManager.shared.deliveryLocation = address.title
            self.update()
            self.show(message: "Your default shop was successfully updated", type: .success)
        })
        
        return shops.list().subheadlineHeader("Select delivery region to get most popular bouquets in your region")
    }
}

// MARK: - SwiftUI Preview
import SwiftUI

struct SelectDeliveryRegionViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: RegionViewController(), MintAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
