//
//  CheckoutViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 28.01.2021.
//

import UIKit
import DSKit
import DSKitFakery

open class CheckoutViewController: DSViewController {
    
    // Random data generator, an wrapper around https://github.com/vadymmarkov/Fakery
    let faker = DSFaker()
    
    // Checkboxes states
    var imTheReceiver: Bool = false
    var iDontKnownAddress: Bool = false
    var phoneNumberIsWhatsAppNumber: Bool = false
    
    // User
    var userEmail: String?
    var userFullName: String?
    var userPhoneNumber: String?
    
    // Recipient
    var recipientEmail: String?
    var recipientFullName: String?
    var recipientPhoneNumber: String?
    var recipientAddress: String?
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Checkout"
        update()
        
        // Bottom button
        let button = DSButtonVM(title: "Continue") { button in
            self.push(CheckoutOptionsViewController())
        }
        
        showBottom(content: button)
    }
    
    func update() {
        show(content: yourDetailsSection(), destinationDetailsSection())
    }
}

// MARK: - Your details

extension CheckoutViewController {
    
    /// Your details section
    /// - Returns: DSSection
    func yourDetailsSection() -> DSSection {
        
        // Email
        let email = DSTextFieldVM.email(text: userEmail, placeholder: "Email")
        email.didUpdate = { textField in self.userEmail = textField.text }
        email.identifier = "email"
        
        // Full name
        let fullName = DSTextFieldVM.name(text: userFullName ,placeholder: "Full name")
        fullName.didUpdate = { textField in self.userFullName = textField.text }
        fullName.identifier = "full name"
        
        // Phone
        let phone = DSTextFieldVM.phone(text: userPhoneNumber ,placeholder: "Phone number")
        phone.didUpdate = { textField in self.userPhoneNumber = textField.text }
        phone.identifier = "phone number"
        
        // I have what-sap on this number
        var whatsApp = checkboxViewModel(title: "I have WhatsApp on this number", checked: phoneNumberIsWhatsAppNumber)
        whatsApp.didTap({ (dd: DSActionVM) in
            
            // Toggle phoneNumberIsWhatsAppNumber
            self.phoneNumberIsWhatsAppNumber = !self.phoneNumberIsWhatsAppNumber
            self.update()
        })
        
        // Your details section
        return [email, fullName, phone, whatsApp].list().headlineHeader("Your details")
    }
}


// MARK: - Destination details

extension CheckoutViewController {
    
    /// Destination details section
    /// - Returns: DSSection
    func destinationDetailsSection() -> DSSection {
        
        var viewModels = [DSViewModel]()
        
        // I'm the receiver checkbox
        var receiver = checkboxViewModel(title: "I'm the receiver", checked: imTheReceiver)
        receiver.didTap({ (dd: DSActionVM) in
            self.imTheReceiver = !self.imTheReceiver
            self.update()
        })
        
        viewModels.append(receiver)
        
        // If i'm not the receiver add fields in viewModels array
        if !imTheReceiver {
            
            // Email
            let email = DSTextFieldVM.email(text: recipientEmail, placeholder: "Email")
            email.didUpdate = { textField in self.recipientEmail = textField.text }
            email.identifier = "email recipient"
            
            // Full name
            let fullName = DSTextFieldVM.name(text: recipientFullName, placeholder: "Full name recipient")
            fullName.didUpdate = { textField in self.recipientFullName = textField.text }
            fullName.identifier = "full name recipient"
            
            // Phone
            let phone = DSTextFieldVM.phone(text: recipientPhoneNumber, placeholder: "Phone number recipient")
            phone.didUpdate = { textField in self.recipientPhoneNumber = textField.text }
            phone.identifier = "phone number recipient"
            
            // Add view models to the array
            viewModels.append(contentsOf: [email, fullName, phone])
        }
        
        // I don't know the address
        var unknownAddress = checkboxViewModel(title: "I don't know the address", checked: iDontKnownAddress)
        unknownAddress.didTap({ (dd: DSActionVM) in
            self.iDontKnownAddress = !self.iDontKnownAddress
            self.update()
        })
        
        viewModels.append(unknownAddress)
        
        // If user does not know the receiver address we will not add
        // address field
        if !iDontKnownAddress {
            
            // Address
            let address = DSTextFieldVM.addressCityAndState(text: recipientAddress, placeholder: "Address")
            address.didUpdate = { textField in self.recipientAddress = textField.text }
            viewModels.append(address)
        }
        
        return viewModels.list().headlineHeader("Delivery details")
    }
}

// MARK: - Destination details

extension CheckoutViewController {
    
    /// Checkbox view model
    /// - Parameters:
    ///   - title: String
    ///   - checked: Bool
    /// - Returns: DSActionVM
    func checkboxViewModel(title: String, checked: Bool) -> DSActionVM {
        
        let composer = DSTextComposer()
        composer.add(type: .custom(font: appearance.fonts.subheadline, color: appearance.primaryView.text.headline), text: title)
        return composer.checkboxActionViewModel(selected: checked)
    }
}

// MARK: - Swift UI preview

import SwiftUI

struct CheckoutViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: CheckoutViewController(), MintAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
