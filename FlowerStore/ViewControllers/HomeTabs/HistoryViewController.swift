//
//  HistoryViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 28.01.2021.
//

import UIKit
import DSKit
import DSKitFakery

class HistoryViewController: DSViewController {
    
    var currentSectionIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "History"
        update()
    }
    
    /// Update current content on the screen
    func update() {
        
        var sections = [DSSection]()
        
        sections.append(getSwitchSectionsSection())
        
        if currentSectionIndex == 0 {
            sections.append(getUpcomingDeliverySection())
        } else if currentSectionIndex == 1 {
            sections.append(getPastDeliveriesSection())
        }

        self.show(content: sections)
    }
}

// MARK: - Switch sections
extension HistoryViewController {
    
    func getSwitchSectionsSection() -> DSSection {
        
        let segment = DSSegmentVM(segments: ["Upcoming", "Delivered"])
        
        segment.didTapOnSegment = { segment in
            self.currentSectionIndex = segment.index
            self.update()
        }
        
        let section = DSListSection(viewModels: [segment])
        return section
    }
}

// MARK: - Sections
extension HistoryViewController {
 
    /// Upcoming
    /// - Returns: DSSection
    func getUpcomingDeliverySection() -> DSSection {
        
        let redTulips = transaction(title: "Red tulips", price: DSPrice(amount: "10.00", currency: "$"))
        let yellowTulips = transaction(title: "Yellow tulips bouquets", price: DSPrice(amount: "10.00", currency: "$"))
      
        return [redTulips, yellowTulips].list()
    }
    
    /// Past
    /// - Returns: DSSection
    func getPastDeliveriesSection() -> DSSection {
        
        let redTulips = transaction(title: "Red tulips", price: DSPrice(amount: "10.00", currency: "$"))
        let yellowTulips = transaction(title: "Yellow tulips bouquets", price: DSPrice(amount: "10.00", currency: "$"))
        return [redTulips, yellowTulips].list()
    }
}

// MARK: - Helpers
extension HistoryViewController {
    
    /// Booking view model
    /// - Parameter service: Service
    /// - Returns: DSViewModel
    func transaction(title: String, price: DSPrice) -> DSViewModel {
        
        let text = DSTextComposer()
        text.add(type: .headline, text: title)
        text.add(type: .subheadline, text: Date().stringFormatted(), icon: UIImage(systemName: "calendar"))
        text.add(price: price)
        
        var model = DSActionVM(composer: text)
        model.style.displayStyle = .grouped(inSection: false)
        
        return model
    }
}
