//
//  ProductGroup.swift
//  DSKit
//
//  Created by Borinschi Ivan on 28.01.2021.
//

import Foundation
import DSKit
import UIKit

struct ProductGroup {
    let title: String
    let products: [Product]
}

extension ProductGroup {
    
    func section(presenter: DSDesignableViewController) -> DSSection {
        
        let section = products.smallModels(presenter: presenter).gallery()
        
        let text = DSTextComposer()
        text.add(type: .headline, text: title)
        var action = DSActionVM(composer: text)
        action.style.displayStyle = .default
        
        action.rightButton(title: "View all", sfSymbolName: "chevron.right", style: .medium) {
            let vc = ProductGroupDetailsViewController(group: self)
            presenter.push(vc)
        }
        
        section.header = action
        return section
    }
}

extension Array where Element == ProductGroup {
    
    func sections(presenter: DSDesignableViewController) -> [DSSection] {
        self.map({ $0.section(presenter: presenter) })
    }
}
