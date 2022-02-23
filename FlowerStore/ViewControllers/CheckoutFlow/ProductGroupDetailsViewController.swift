//
//  ProductGroupDetailsViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 28.01.2021.
//

import UIKit
import DSKit

open class ProductGroupDetailsViewController: DSViewController {
    
    let group: ProductGroup
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        title = group.title
        
        // Show group section
        show(content: group.products.largeModels(presenter: self).list())
    }
    
    init(group: ProductGroup) {
        self.group = group
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SwiftUI Preview
import SwiftUI

struct ProductGroupDetailsViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let group = ShopManager.shared.rosesGroup()
            PreviewContainer(VC: ProductGroupDetailsViewController(group: group), MintAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
