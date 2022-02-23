//
//  CheckoutOptionsViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 28.01.2021.
//

import UIKit
import DSKit
import DSKitFakery

final class CheckoutOptionsViewController: DSViewController {
    
    // Random data generator, an wrapper around https://github.com/vadymmarkov/Fakery
    let faker = DSFaker()
    
    // Products 
    var products = [Product]()
    
    // Grating cards
    var greetingCards = [Product]()
    
    // Delivery options
    var deliveryOptions = [Delivery]()
    
    // Additional options
    var options = [Option]()
    
    var greetingMessage: String? = "Add the text which will be printed in the card"
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Options"
        
        prepareContent()
        update()
        
        // Show continue button
        let button = DSButtonVM(title: "Continue") { [unowned self] button in
            self.push(PaymentMethodViewController())
        }
        showBottom(content: button)
    }
    
    func update() {
        show(content: additionalProductsSection(), additionalOptionsSection(), greetingCardsSection(), deliveryOptionSection())
    }
}

// MARK: - Models
extension CheckoutOptionsViewController {
    
    // Product
    class Product {
        
        internal init(title: String, price: DSPrice, image: URL? = nil, selected: Bool = false) {
            self.title = title
            self.price = price
            self.selected = selected
            self.image = image
        }
        
        let title: String
        let price: DSPrice
        var image: URL? = nil
        var selected: Bool
    }
    
    // Delivery
    class Delivery {
        
        internal init(title: String, price: DSPrice, selected: Bool = false) {
            self.title = title
            self.price = price
            self.selected = selected
        }
        
        let title: String
        let price: DSPrice
        var selected: Bool
    }
    
    // Option
    class Option {
        
        internal init(title: String, icon: String, selected: Bool = false) {
            self.title = title
            self.selected = selected
            self.icon = icon
        }
        
        let title: String
        var icon: String
        var selected: Bool
    }
}

// MARK: - Prepare content
extension CheckoutOptionsViewController {
    
    /// Prepare content
    func prepareContent() {
        
        // Products
        products.append(Product(title: "Balloon Love", price: DSPrice(amount: "14.00", currency: "$"), image: URL.balloons))
        products.append(Product(title: "Bunny", price: DSPrice(amount: "6.00", currency: "$"), image: URL.bunnyGift))
        products.append(Product(title: "Wine bottle", price: DSPrice(amount: "7.00", currency: "$"), image: URL.wineBottleGift))
        
        // Cards
        greetingCards.append(Product(title: "Standard card ", price: DSPrice(amount: "0.00", currency: "$", discountBadge: "Free"), image: URL.standardCard))
        greetingCards.append(Product(title: "Card love you", price: DSPrice(amount: "7.00", currency: "$"), image: URL.cardLoveIt))
        greetingCards.append(Product(title: "Card for you", price: DSPrice(amount: "17.00", currency: "$"), image: URL.cardForYou))
        
        // Options
        options.append(Option(title: "Call the recipient in advance", icon: "phone.circle.fill"))
        options.append(Option(title: "Video on delivery", icon: "video.fill"))
        options.append(Option(title: "Photo on delivery", icon: "camera.fill"))
        options.append(Option(title: "Remember in a year", icon: "bell.badge.fill"))
        
        // Delivery
        deliveryOptions.append(Delivery(title: "Special delivery", price: DSPrice(amount: "30.00", currency: "$")))
        deliveryOptions.append(Delivery(title: "Traditional delivery", price: DSPrice(amount: "35.00", currency: "$")))
    }
}

// MARK: - Greeting cards section
extension CheckoutOptionsViewController {
    
    /// Greeting cards section
    /// - Returns: DSSection
    func greetingCardsSection() -> DSSection {
        
        // Map all products options in DSViewModel array
        var models = greetingCards.map { product -> DSViewModel in
            
            let composer = DSTextComposer()
            
            // If option is selected we will show `headline` color else `subheadline`
            let type: DSTextType = .text(font: .subheadline, color: product.selected ? .headline : .subheadline)
            composer.add(type: type, text: product.title)
            composer.add(price: product.price)
            
            var checkbox = composer.checkboxActionViewModel(selected: product.selected)
            
            checkbox.leftImage(url: product.image,
                               style: .themeCornerRadius,
                               size: .size(CGSize(width: 70, height: 60)),
                               contentMode: .scaleAspectFill)
            
            // Handle did tap on option
            checkbox.didTap { [unowned self] (_: DSActionVM) in
                
                // Change option selected state
                product.selected = !product.selected
                self.update()
            }
            
            return checkbox
        }
        
        let textField = DSTextViewVM(text: greetingMessage)
        models.append(textField)
        
        return models.list().headlineHeader("Greeting cards")
    }
}

// MARK: - Delivery options
extension CheckoutOptionsViewController {
    
    /// Delivery options
    /// - Returns: DSSection
    func deliveryOptionSection() -> DSSection {
        
        // Map all delivery options in DSViewModel array
        let options = deliveryOptions.map { (option) -> DSViewModel in
            
            let composer = DSTextComposer()
            
            // If option is selected we will show `headline` color else `subheadline`
            let type: DSTextType = .text(font: .subheadline, color: option.selected ? .headline : .subheadline)
            composer.add(type: type, text: option.title)
            var checkbox = composer.checkboxActionViewModel(selected: option.selected)
            
            // Handle did tap on option
            checkbox.didTap { [unowned self] (_: DSActionVM) in
                
                // Change option selected state
                option.selected = !option.selected
                self.update()
            }
            
            return checkbox
        }
        
        // Return section with headline header
        return options.list().headlineHeader("Delivery Options")
    }
}

// MARK: - Additional products
extension CheckoutOptionsViewController {
    
    /// Additional products
    /// - Returns: DSSection
    func additionalProductsSection() -> DSSection {
        
        // Map all products options in DSViewModel array
        let models = products.map { product -> DSViewModel in
            
            let composer = DSTextComposer()
            
            // If option is selected we will show `headline` color else `subheadline`
            let type: DSTextType = .text(font: .subheadline, color: product.selected ? .headline : .subheadline)
            composer.add(type: type, text: product.title)
            composer.add(price: product.price)
            
            var checkbox = composer.checkboxActionViewModel(selected: product.selected)
            checkbox.leftImage(url: product.image,
                               style: .themeCornerRadius,
                               size: .size(CGSize(width: 70, height: 60)),
                               contentMode: .scaleAspectFill)
            
            // Handle did tap on option
            checkbox.didTap { [unowned self] (_: DSActionVM) in
                
                // Change option selected state
                product.selected = !product.selected
                self.update()
            }
            
            return checkbox
        }
        
        return models.list().headlineHeader("Additional products")
    }
}

// MARK: - Additional options
extension CheckoutOptionsViewController {
    
    /// Additional options
    /// - Returns: DSSection
    func additionalOptionsSection() -> DSSection {
        
        let models = options.map { option -> DSViewModel in
            
            let composer = DSTextComposer()
            
            // If option is selected we will show `headline` color else `subheadline`
            let type: DSTextType = .text(font: .subheadline, color: option.selected ? .headline : .subheadline)
            composer.add(type: type, text: option.title)
            
            var checkbox = composer.checkboxActionViewModel(selected: option.selected)
            checkbox.leftIcon(sfSymbolName: option.icon, tintColor: .text(option.selected ? .headline : .subheadline))
            
            // Handle did tap on option
            checkbox.didTap { [unowned self] (_: DSActionVM) in
                
                // Change option selected state
                option.selected = !option.selected
                self.update()
            }
            
            return checkbox
            
        }
        
        return models.list().headlineHeader("Additional options")
    }
}

// MARK: - Swift UI preview

import SwiftUI

struct CheckoutOptionsViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: CheckoutOptionsViewController(), MintAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
