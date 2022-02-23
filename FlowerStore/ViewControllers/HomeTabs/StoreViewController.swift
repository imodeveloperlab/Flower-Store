//
//  StoreViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 28.01.2021.
//

import UIKit
import DSKit
import DSKitFakery
import DSKitCalendar

open class StoreViewController: DSViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        title = "Store"
        updateContent()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateContent()
    }
    
    func updateContent() {
        
        var sections = [DSSection]()
        
        // Select location and time
        sections.append(getSetLocationAndTimeSection())
        
        // Top products section
        sections.append(getTopProductsSection())
        
        // Categories
        sections.append(getCategoriesSection())
        
        // Transform all products, int to sections
        let productSections = ShopManager.shared.allProductsGroups().sections(presenter: self)
        sections.append(contentsOf: productSections)
        
        show(content: sections)
    }
}

// MARK: - Top Products

extension StoreViewController {
    
    /// Top product section
    /// - Returns: <#description#>
    func getTopProductsSection() -> DSSection {
        
        let models = ShopManager.shared.topProducts().map { (product) -> DSViewModel in
            
            let text = DSTextComposer()
            text.add(type: .headline, text: product.title)
            text.add(price: product.price)
            
            var action = DSActionVM(composer: text)
            action.topImage(url: product.picture)
            action.height = .absolute(250)
            
            action.didTap { [unowned self] (_: DSActionVM) in
                let vc = ProductDetailsViewController(product: product)
                vc.hidesBottomBarWhenPushed = true
                self.push(vc)
            }
            
            return action
        }
        
        return models.gallery().headlineHeader("Top bouquets")
    }
}

// MARK: - Categories

extension StoreViewController {
    
    func getCategoriesSection() -> DSSection {
        
        let models = ShopManager.shared.allProductsGroups().map { (group) -> DSViewModel in
            
            let composer = DSTextComposer()
            composer.add(type: .headlineWithSize(14), text: group.title)
            
            var action = composer.actionViewModel()
            action.didTap({ (action: DSActionVM) in
                self.push(ProductGroupDetailsViewController(group: group))
            })
            
            return action
        }
        
        return models.grid().headlineHeader("Categories")
    }
}

// MARK: - Time and location

extension StoreViewController {
    
    func getSetLocationAndTimeSection() -> DSSection {
        
        let section = [getSelectDeliveryDateViewModel(), getSelectLocationViewModel()].list()
        section.subheadlineHeader("Time and location, for better results")
        return section
    }
    
    /// Select delivery date view model
    /// - Returns: DSViewModel
    func getSelectDeliveryDateViewModel() -> DSViewModel {
        
        var title = "Date"
        var subtitle = "Select delivery date"
        
        if let date = ShopManager.shared.deliveryDate {
            title = date.stringFormatted()
            subtitle = "Delivery date"
        }
        
        // Text
        let text = DSTextComposer()
        text.add(type: .headline, text: title)
        text.add(type: .caption2, text: subtitle)
        
        // Transform text in action
        var action = text.actionViewModel()
        action.leftIcon(sfSymbolName: "calendar")
        action.rightArrow()
        
        // Handle did tap on action
        action.didTap { [unowned self] (_: DSActionVM) in
            
            let startDate = Date()
            guard let endDate = Calendar.current.date(byAdding: .month, value: 3, to: startDate) else {
                return
            }
            
            // Instantiate and push (show) select day controller
            let selectDay = DSCalendarViewController(startDate: startDate, endDate: endDate, excludeDates: [Date]())
            self.push(selectDay)
            
            // Handle did select date in `selectDay` view controller
            selectDay.didSelectDate = { date in
                ShopManager.shared.deliveryDate = date
                self.pop(to: self)
                self.updateContent()
            }
        }
        
        return action
    }
    
    /// Select location view model
    /// - Returns: DSViewModel
    func getSelectLocationViewModel() -> DSViewModel {
        
        var title = "Location"
        var subtitle = "Select delivery region"
        
        if let deliveryLocation = ShopManager.shared.deliveryLocation {
            title = deliveryLocation
            subtitle = "Address will be specified at checkout"
        }
        
        // Text
        let text = DSTextComposer()
        text.add(type: .headline, text: title)
        text.add(type: .caption2, text: subtitle)
        
        // Transform text to action
        var action = text.actionViewModel()
        action.leftIcon(sfSymbolName: "mappin.circle.fill")
        action.rightArrow()
        
        // Handle did tap
        action.didTap { [unowned self] (_: DSActionVM) in
            let vc = RegionViewController()
            vc.hidesBottomBarWhenPushed = true
            self.push(vc)
        }
        
        return action
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct StoreViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: StoreViewController(), MintAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
