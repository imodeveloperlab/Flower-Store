//
//  CheckoutOptionsViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 28.01.2021.
//

import UIKit
import DSKit
import DSKitFakery

open class ConfirmationViewController: DSViewController {
    
    // Random data generator, an wrapper around https://github.com/vadymmarkov/Fakery
    let faker = DSFaker()
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Confirmation"
        self.show(content: productInfo(), deliverySection(), totalsSection(), paymentSection())
        
        // Bottom button
        let button = DSButtonVM(title: "Pay") { [unowned self] button in
            self.show(message: "Your order was successfully paid", type: .success, timeOut: 1) {
                self.popToRoot()
            }
        }
        
        self.showBottom(content: button)
    }
}

// MARK: - Product info

extension ConfirmationViewController {
    
    func productInfo() -> DSSection {
        
        let image = DSImageVM(imageUrl: URL.tulipsYellow, height: .absolute(170), displayStyle: .circle, contentMode: .scaleAspectFill)
        let text = DSLabelVM(.headline, text: "Yellow tulips", alignment: .center)
        
        return [image, text].list()
    }
}

// MARK: - Delivery section

extension ConfirmationViewController {
    
    func deliverySection() -> DSSection {
        
        let date = textRow(title: "", details: Date().stringFormatted(), icon: "calendar")
        let phone = textRow(title: "", details: faker.phoneNumber, icon: "phone.fill")
        let address = textRow(title: "", details: faker.streetAddress, icon: "map.fill")
        
        return [date, phone, address].list(separator: true, grouped: true).subheadlineHeader("Delivery")
    }
}

// MARK: - Delivery section

extension ConfirmationViewController {
    
    func totalsSection() -> DSSection {
        
        var viewModels = [DSViewModel]()
        viewModels.append(serviceRow(title: "Red roses bouquet", price: DSPrice(amount: "45.00", currency: "$")))
        viewModels.append(serviceRow(title: "Special delivery", price: DSPrice(amount: "15.00", currency: "$")))
        viewModels.append(serviceRow(title: "Love her CARD", price: DSPrice(amount: "14.00", currency: "$")))
        viewModels.append(serviceRow(bold: true, title: "Total", price: DSPrice(amount: "74.00", currency: "$")))
        return viewModels.list(separator: true, grouped: true).subheadlineHeader("Totals")
    }
}

// MARK: - Payment section

extension ConfirmationViewController {
    
    func paymentSection() -> DSSection {
        
        var action = DSActionVM(title: "Visa")
        action.style.displayStyle = .default
        let image = UIImage(named: "Visa", in: Bundle(for: self.classForCoder), compatibleWith: nil)
        action.leftImage(image: image, style: .default, size: .size(CGSize(width: 50, height: 25)), contentMode: .scaleAspectFit)
        return action.list(separator: true, grouped: true).subheadlineHeader("Payment")
    }
}

// MARK: - Helpers

extension ConfirmationViewController {
    
    /// Text row
    /// - Parameters:
    ///   - title: String
    ///   - details: String
    ///   - icon: String
    /// - Returns: DSActionVM
    func textRow(title: String, details: String, icon: String) -> DSActionVM {
        
        let text = DSTextComposer()
        text.add(type: .headline, text: title)
        text.add(type: .subheadline, text: details, newLine: false)
        var row = DSActionVM(composer: text)
        row.leftIcon(sfSymbolName: icon, size: CGSize(width: 20, height: 20))
        row.leftViewPosition = .top
        row.style.displayStyle = .grouped(inSection: false)
        return row
    }
    
    /// Row
    /// - Parameters:
    ///   - bold: Bool
    ///   - title: String
    ///   - price: DSPrice
    /// - Returns: DSViewModel
    func serviceRow(bold: Bool = false, title: String, price: DSPrice) -> DSViewModel {
        
        let composer = DSTextComposer()
        composer.add(type:  bold ? .headline : .subheadline, text: title)
        
        var action = composer.actionViewModel()
        action.rightPrice(price: price)
        
        return action
    }
}

// MARK: - Swift UI preview

import SwiftUI

struct ConfirmationViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: ConfirmationViewController(), MintAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
