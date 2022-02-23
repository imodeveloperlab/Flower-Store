//
//  ProductDetailsViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 28.01.2021.
//

import UIKit
import DSKit

open class ProductDetailsViewController: DSViewController {
    
    let product: Product
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        update()
    }
    
    func update() {
        
        // Product details
        let title = DSLabelVM(.title1, text: product.title)
        let description = DSLabelVM(.subheadline, text: product.description)
        
        // Show content
        show(content: [picturesGallerySection(),
                       [title, description].list().zeroTopInset(),
                       [getPriceVM(), getQuantityPickerVM()].grid(),
                       getTopProductsSection()])
        
        // Buy button
        let buyNow = DSButtonVM(title: "Buy Now", icon: UIImage(systemName: "cart.fill")) { [unowned self] tap in
            self.push(YouMayAlsoLikeViewController())
        }
        
        // Show bottom content
        showBottom(content: buyNow)
    }
    
    /// Init with product
    /// - Parameter product: Product
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - You may also like

extension ProductDetailsViewController {
    
    /// Top products section
    /// - Returns: DSSection
    func getTopProductsSection() -> DSSection {
        
        /// Map top products in to DSViewModel array
        let models = ShopManager.shared.topProducts().map { (product) -> DSViewModel in
            
            // Text
            let text = DSTextComposer()
            text.add(type: .subheadline, text: product.title)
            var action = text.actionViewModel()
            
            // Image
            action.topImage(url: product.picture)
            
            // Size
            action.height = .absolute(150)
            action.width = .fractional(0.45)
            
            // Handle did tap on DSActionVM
            action.didTap { [unowned self] (_: DSActionVM) in
                let vc = ProductDetailsViewController(product: product)
                vc.hidesBottomBarWhenPushed = true
                self.push(vc)
            }
            
            return action
        }
        
        return models.gallery().subheadlineHeader("You may also like")
    }
}

// MARK: - Gallery
extension ProductDetailsViewController {
    
    /// Gallery section
    /// - Returns: DSSection
    func picturesGallerySection() -> DSSection {
        
        let urls = [product.picture,
                    URL.topFlowers2,
                    URL.topFlowers3].compactMap({ $0 })
        
        let pictureModels = urls.map { url -> DSViewModel in
            var view = DSImageVM(imageUrl: url, height: .absolute(UIScreen.main.bounds.height / 3), displayStyle: .themeCornerRadius)
            
            view.supplementaryItems = [likeButton()]
            
            return view
        }
        
        let pageControl = DSPageControlVM(type: .viewModels(pictureModels))
        return pageControl.list().zeroLeftRightInset()
    }
    
    /// Like button
    /// - Returns: DSSupplementaryView
    func likeButton() -> DSSupplementaryView {
        
        let composer = DSTextComposer()
        composer.add(sfSymbol: "heart.fill",
                     style: .medium,
                     tint: .custom(Int.random(in: 0...1) == 0 ? .red : .white))
        
        var action = DSActionVM(composer: composer)
        
        action.didTap { [unowned self] (_: DSActionVM) in
            self.dismiss()
        }
        
        let supView = DSSupplementaryView(view: action,
                                          position: .rightTop,
                                          background: .lightBlur,
                                          insets: .interItemSpacing)
        return supView
    }
}

// MARK: - Price
extension ProductDetailsViewController {
    
    /// Price view model
    /// - Returns: DSActionVM
    func getPriceVM() -> DSActionVM {
        
        let text = DSTextComposer()
        text.add(price: product.price, size: .large, newLine: false)
        var action = DSActionVM(composer: text)
        action.style.displayStyle = .default
        action.height = .absolute(30)
        
        return action
    }
    
    /// Quantity picker
    /// - Returns: DSActionVM
    func getQuantityPickerVM() -> DSViewModel {
        let picker = DSQuantityPickerVM(quantity: 20)
        return picker
    }
}

// MARK: - SwiftUI Preview
import SwiftUI

struct ProductDetailsViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let product = Product(title: "Orange bouquets",
                                  description: "Red roses symbolize love and romance and are the perfect Valentine's Day rose.",
                                  picture: URL.topFlowers1,
                                  price: DSPrice(amount: "13.00", regularAmount: "15.00", currency: "$"))
            
            PreviewContainer(VC: ProductDetailsViewController(product: product), PeachAppearance())
        }
    }
}
