//
//  ShopManager.swift
//  DSKit
//
//  Created by Borinschi Ivan on 28.01.2021.
//

import Foundation
import DSKit

class ShopManager {
    
    public var deliveryDate: Date?
    public var deliveryLocation: String?
    public var selectedProduct: Product?
    
    public var isDateAndRegionSelected: Bool {
        return deliveryDate != nil && deliveryLocation != nil
    }
    
    static let shared = ShopManager()
    
    public init() {
    }
    
    func reset() {
        deliveryDate = nil
        deliveryLocation = nil
    }
}

extension ShopManager {
    
    func allProductsGroups() -> [ProductGroup] {

        [rosesGroup(),
         tulipsGroup(),
         echeveriaGroup(),
         hydrangeaGroup()]
    }
}

extension ShopManager {
    
    func topProducts() -> [Product] {
        
        let product1 = Product(title: "Orange bouquets",
                               description: "Red roses symbolize love and romance and are the perfect Valentine's Day rose.",
                               picture: URL.topFlowers1,
                               price: DSPrice(amount: "13.00", regularAmount: "15.00", currency: "$"))
        
        let product2 = Product(title: "Special tulips",
                               description: "Special tulips",
                               picture: URL.topFlowers2,
                               price: DSPrice(amount: "5.00", currency: "$"))
      
        let product3 = Product(title: "Blue",
                               description: "Blue hydrangeas from the big-leaf family are only blue because of the soil they are grown in.",
                               picture: URL.topFlowers3,
                               price: DSPrice(amount: "6.00", currency: "$"))
        
        return [product1, product2, product3]
    }
}

extension ShopManager {
    
    func rosesGroup() -> ProductGroup {
        ProductGroup(title: "Roses", products: roses())
    }
    
    func tulipsGroup() -> ProductGroup {
        ProductGroup(title: "Tulips", products: tulips())
    }
    
    func echeveriaGroup() -> ProductGroup {
        ProductGroup(title: "Roses", products: echeveria())
    }
    
    func hydrangeaGroup() -> ProductGroup {
        ProductGroup(title: "Hydrangea", products: hydrangea())
    }
}

extension ShopManager {
    
    func roses() -> [Product] {
        
        let product1 = Product(title: "Bouquet elegance Red",
                               description: "Red roses symbolize love and romance and are the perfect Valentine's Day rose.",
                               picture: URL.rosesRed,
                               price: DSPrice(amount: "5.00", currency: "$"))
        
        let product2 = Product(title: "Pink Roses",
                               description: "Pink roses symbolize gratitude, grace, and joy, pink rose symbolism can vary with hot pink expressing recognition...",
                               picture: URL.rosesPink,
                               price: DSPrice(amount: "6.00", currency: "$", discountBadge: "1+1 Free"))
        
        let product3 = Product(title: "Multicolor roses \"Olanda 30-40cm\"",
                               description: "Multicolor roses \"Olanda30-40cm\"",
                               picture: URL.rosesWhite,
                               price: DSPrice(amount: "4.00", currency: "$"))
        
        let product4 = Product(title: "Yellow Rosses",
                               description: "Yellow roses are a symbol of friendship and caring.",
                               picture: URL.rosesYellow,
                               price: DSPrice(amount: "2.50", currency: "$"))
        
        return [product4, product2, product3, product1]
    }
    
    func tulips() -> [Product] {
        
        let product1 = Product(title: "White tulips",
                               description: "White tulips have a meaning of forgiveness, respect, purity and honour.",
                               picture: URL.tulipsWhite,
                               price: DSPrice(amount: "7.00", currency: "$"))
        
        let product2 = Product(title: "Yellow bouquets",
                               description: "The meaning of yellow tulips has evolved somewhat, from once representing hopeless love to now being a common expression for cheerful thoughts and sunshine.",
                               picture: URL.tulipsYellow,
                               price: DSPrice(amount: "4.00", currency: "$"))
        
        let product3 = Product(title: "Special tulips",
                               description: "Special tulips",
                               picture: URL.tulipsSpecial,
                               price: DSPrice(amount: "4.00", regularAmount: "6.00", currency: "$", discountBadge: "20% Off"))
        
        let product4 = Product(title: "Multicolor paradise",
                               description: "Like many flowers, different colors of tulips also often carry their own significance.",
                               picture: URL.tulipsMulticolor,
                               price: DSPrice(amount: "60.00", currency: "$"))
        
        let product5 = Product(title: "Red tulips",
                               description: "The is one of the world's most easily recognized and loved flowers",
                               picture: URL.tulipsRed,
                               price: DSPrice(amount: "15.00", currency: "$"))
        
        return [product4, product5, product1, product2, product3]
    }
    
    func echeveria() -> [Product] {
        
        let product1 = Product(title: "Pink",
                               description: "Echeveria 'Pink Champagne' is a cross between Echeveria agavoides 'Romeo' and Echeveria laui.",
                               picture: URL.echeveriaPink,
                               price: DSPrice(amount: "7.00", currency: "$"))
        
        let product2 = Product(title: "Green",
                               description: "Interestingly, perfectly watered succulents often revert to a green color.",
                               picture: URL.echeveriaGreen,
                               price: DSPrice(amount: "4.00", currency: "$", discountBadge: "+Gift"))
        
        return [product1, product2]
    }
    
    func hydrangea() -> [Product] {
        
        let product1 = Product(title: "Red",
                               description: "Many times plants sold as red hydrangeas have actually had deep pink blooms, not a true red.",
                               picture: URL.hydrangeaRed,
                               price: DSPrice(amount: "7.00", regularAmount: "8.00", currency: "$", discountBadge: "-$1"))
        
        let product2 = Product(title: "Pink",
                               description: "To change hydrangea flowers from blue to pink, you need to remove the aluminum from the soil.",
                               picture: URL.hydrangeaPink,
                               price: DSPrice(amount: "4.00", regularAmount: "8.00", currency: "$", discountBadge: "50% Off"))
        
        let product3 = Product(title: "Blue",
                               description: " Blue hydrangeas from the bigleaf family are only blue because of the soil they are grown in.",
                               picture: URL.hydrangeaBlue,
                               price: DSPrice(amount: "6.00", currency: "$"))
        
        let product4 = Product(title: "Green",
                               description: "As the sepals age, the pink, blue, or white pigments are overpowered by the green",
                               picture: URL.hydrangeaGreen,
                               price: DSPrice(amount: "60.00", currency: "$"))
        
        return [product1, product2, product3, product4]
    }
}

