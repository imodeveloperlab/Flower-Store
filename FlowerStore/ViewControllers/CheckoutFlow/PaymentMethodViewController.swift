//
//  CheckoutOptionsViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 28.01.2021.
//

import UIKit
import DSKit
import DSKitFakery

open class PaymentMethodViewController: DSViewController {
    
    // Random data generator, an wrapper around https://github.com/vadymmarkov/Fakery
    let faker = DSFaker()
    
    var paymentMethods = [PaymentMethod]()
    var selectedMethod: PaymentMethod?
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Payment"
        
        prepareContent()
        update()
        
        let button = DSButtonVM(title: "Continue") { [unowned self] button in
            self.push(ConfirmationViewController())
        }
        showBottom(content: button)
    }
    
    func update() {
        show(content: paymentMethodsSection())
    }
}

// MARK: - Models
extension PaymentMethodViewController {
    
    struct PaymentMethod: Equatable {
        
        internal init(title: String, iconName: String) {
            self.title = title
            self.iconName = iconName
        }
        
        let title: String
        var iconName: String
    }
}

// MARK: - Prepare options
extension PaymentMethodViewController {
    
    func prepareContent() {
        
        paymentMethods.append(PaymentMethod(title: "Visa", iconName: "Visa"))
        paymentMethods.append(PaymentMethod(title: "Maestro", iconName: "Maestro"))
        paymentMethods.append(PaymentMethod(title: "Bitcoin", iconName: "Bitcoin"))
        paymentMethods.append(PaymentMethod(title: "Apple Pay", iconName: "ApplePay"))
        paymentMethods.append(PaymentMethod(title: "American Express", iconName: "AmericanExpress"))
        paymentMethods.append(PaymentMethod(title: "Paypal", iconName: "Paypal"))
        paymentMethods.append(PaymentMethod(title: "Stripe", iconName: "Stripe"))
        paymentMethods.append(PaymentMethod(title: "Western Union", iconName: "WesternUnion"))
    }
}

// MARK: - Section
extension PaymentMethodViewController {
    
    /// Payment methods section
    /// - Returns: DSSection
    func paymentMethodsSection() -> DSSection {
        
        let models = paymentMethods.map { method -> DSViewModel in
            paymentMethodViewModel(method: method)
        }
                
        return models.list().subheadlineHeader("Choose a payment method")
    }
}

// MARK: - Checkbox view models
extension PaymentMethodViewController {
    
    /// Product checkbox view model
    /// - Parameter method: PaymentMethod
    /// - Returns: DSActionVM
    func paymentMethodViewModel(method: PaymentMethod) -> DSActionVM {
        
        let composer = DSTextComposer()
        composer.add(type: .headline, text: method.title)
        
        let selected = selectedMethod == method
        var checkbox = composer.checkboxActionViewModel(selected: selected)
        let image = UIImage(named: method.iconName, in: Bundle(for: self.classForCoder), compatibleWith: nil)
        checkbox.leftImage(image: image, style: .default, size: .size(CGSize(width: 60, height: 35)), contentMode: .scaleAspectFit)
        
        // Handle did top on pay method
        checkbox.didTap { [unowned self] (action: DSActionVM) in
            self.selectedMethod = method
            self.update()
        }
        
        return checkbox
    }
}

// MARK: - Swift UI preview

import SwiftUI

struct PaymentMethodViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: PaymentMethodViewController(), MintAppearance(), true).edgesIgnoringSafeArea(.all)
        }
    }
}
