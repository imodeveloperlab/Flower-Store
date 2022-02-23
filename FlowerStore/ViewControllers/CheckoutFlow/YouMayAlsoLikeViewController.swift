//
//  YouMayAlsoLikeViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 20.02.2021.
//  Copyright © 2021 Borinschi Ivan. All rights reserved.
//

import UIKit
import DSKit

open class YouMayAlsoLikeViewController: DSViewController {
    
    var products = [Product]()
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Also add"
        prepareProducts()
        
        let skipButton = DSButtonVM(title: "Next") { (tap) in
            self.push(CheckoutViewController())
        }
        
        // Bottom button
        showBottom(content: skipButton)
        
        //Update content in the middle
        update()
    }
    
    func update() {
        show(content: productsSection())
    }
}

// MARK: - Products section
extension YouMayAlsoLikeViewController {
    
    func productsSection() -> DSSection {
        
        let models = products.map { (product) -> DSViewModel in
            
            let composer = DSTextComposer()
            composer.add(type: .subheadline, text: product.title)
            composer.add(price: product.price, size: .medium)
            
            var checkbox = composer.checkboxActionViewModel(selected: product.selected)
            checkbox.topImage(url: product.imageUrl, height: .unknown, contentMode: .scaleAspectFill)
            checkbox.height = .absolute(190)
            
            // Handle did tap on option
            checkbox.didTap { [unowned self] (_: DSActionVM) in
                
                // Change option selected state
                product.selected = !product.selected
                self.update()
            }
            
            return checkbox
        }
       
        return models.grid()
    }
}

// MARK: - Prepare content
extension YouMayAlsoLikeViewController {
    
    class Product {
        
        internal init(title: String, imageUrl: URL?, price: DSPrice, selected: Bool = false) {
            self.title = title
            self.imageUrl = imageUrl
            self.price = price
            self.selected = selected
        }
        
        let title: String
        let imageUrl: URL?
        let price: DSPrice
        var selected: Bool
    }
    
    func prepareProducts() {
        
        let cactus = Product(title: "Cactus", imageUrl: URL.cactusGift, price: DSPrice(amount: "10.00", currency: "$"))
        let rocher = Product(title: "Ferrero Rocher", imageUrl: URL.ferreroRocherGift, price: DSPrice(amount: "15.00", currency: "$"))
        let bunny = Product(title: "Bunny", imageUrl: URL.bunnyGift, price: DSPrice(amount: "12.00", currency: "$"))
        let wine = Product(title: "Wine bottle", imageUrl: URL.wineBottleGift, price: DSPrice(amount: "34.00", currency: "$"))
        let secret = Product(title: "Secret Gift", imageUrl: URL.secretGift, price: DSPrice(amount: "13.00", currency: "$"))
        let journal = Product(title: "Journal", imageUrl: URL.journalGift, price: DSPrice(amount: "13.00", currency: "$"))
        let box = Product(title: "Box Gift", imageUrl: URL.boxGift, price: DSPrice(amount: "3.00", currency: "$"))
        let some = Product(title: "Some Gift", imageUrl: URL.someGift, price: DSPrice(amount: "3.00", currency: "$"))
        
        products.append(contentsOf: [some, cactus, rocher, bunny, wine, secret, journal, box])
    }
}

// MARK: - SwiftUI Preview
import SwiftUI

struct YouMayAlsoLikeViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: YouMayAlsoLikeViewController(), MintAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
