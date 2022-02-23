//
//  Product.swift
//  DSKit
//
//  Created by Borinschi Ivan on 28.01.2021.
//

import Foundation
import DSKit
import UIKit

struct Product {
    let title: String
    let description: String
    let picture: URL?
    let price: DSPrice
}

extension Product {

    /// Get small view model for product
    /// - Parameters:
    ///   - height: CGFloat
    ///   - presenter: DSDesignableViewController
    /// - Returns: DSViewModel
    func smallModel(height: CGFloat, presenter: DSDesignableViewController) -> DSViewModel {
        
        // Text
        let text = DSTextComposer()
        text.add(type: .subheadline, text: title)
        text.add(price: price, size: .medium)
        
        // Action
        var action = DSActionVM(composer: text)
        action.topImage(url: picture, height: .equalTo(height))
        action.width = .fractional(0.45)
        action.height = .absolute(height)
        
        // Handle did tap
        action.didTap { (_: DSActionVM) in
            let vc = ProductDetailsViewController(product: self)
            vc.hidesBottomBarWhenPushed = true
            presenter.push(vc)
        }
        
        return action
    }
    
    /// Get large view model for product
    /// - Parameters:
    ///   - height: CGFloat
    ///   - presenter: DSDesignableViewController
    /// - Returns: DSViewModel
    func largeModel(height: CGFloat, presenter: DSDesignableViewController) -> DSViewModel {
        
        // Text
        let text = DSTextComposer()
        text.add(type: .headline, text: title)
        text.add(type: .subheadline, text: description)
        text.add(price: price, size: .medium)
        
        // Action
        var action = DSActionVM(composer: text)
        action.topImage(url: picture)
        action.height = .absolute(height)
        
        // Handle did tap
        action.didTap { (_: DSActionVM) in
            let vc = ProductDetailsViewController(product: self)
            vc.hidesBottomBarWhenPushed = true
            presenter.push(vc)
        }
        
        return action
    }
}

extension Array where Element == Product {
    
    func smallModels(height: CGFloat = 200, presenter: DSDesignableViewController) -> [DSViewModel] {
        self.map { (product) -> DSViewModel in
            product.smallModel(height: height, presenter: presenter)
        }
    }
}

extension Array where Element == Product {
    
    func largeModels(height: CGFloat = 270, presenter: DSDesignableViewController) -> [DSViewModel] {
        self.map { (product) -> DSViewModel in
            product.largeModel(height: height, presenter: presenter)
        }
    }
}
