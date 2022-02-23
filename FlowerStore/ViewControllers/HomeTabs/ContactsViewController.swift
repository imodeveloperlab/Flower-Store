//
//  StoreViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 28.01.2021.
//

import UIKit
import DSKit
import DSKitFakery

open class ContactsViewController: DSViewController {
    
    // Random data generator, an wrapper around https://github.com/vadymmarkov/Fakery
    let faker = DSFaker()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"
        show(content: [getContactsSection()])
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// MARK: - Contacts
extension ContactsViewController {
    
    /// Contacts section
    /// - Returns: DSSection
    func getContactsSection() -> DSSection {
        
        let phone = textRow(title: "Phone: ", details: faker.phoneNumber, icon: "phone.fill")
        let address = textRow(title: "Address: ", details: faker.streetAddress, icon: "map.fill")
        let workingHours = textRow(title: "Working Hours: ", details: "Open ⋅ Closes 5PM", icon: "calendar.badge.clock")
        let health = textRow(title: "Health and safety: ", details: "Mask required · Temperature check required · Staff wear masks · Staff get temperature checks", icon: "info.circle.fill")
        let map = DSMapVM(coordinate: faker.address.coordinate)
        let button = DSButtonVM(title: "Get directions", icon: UIImage(systemName: "map.fill"))
        
        return [phone, address, workingHours, health, map, button].list()
    }
    
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
        row.leftIcon(sfSymbolName: icon, size: CGSize(width: 18, height: 18))
        row.leftViewPosition = .top
        row.style.displayStyle = .grouped(inSection: false)
        return row
    }
}
