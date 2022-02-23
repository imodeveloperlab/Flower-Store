//
//  StoreViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 28.01.2021.
//

import UIKit
import DSKit
import DSKitFakery

open class AboutUsViewController: DSViewController {
    
    // Random data generator, an wrapper around https://github.com/vadymmarkov/Fakery
    let faker = DSFaker()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        title = "About Us"
        show(content: [getInfoHeaderSection(),
                       getInfoGallerySection(),
                       getInfoDescriptionSection()])
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// MARK: - Info
extension AboutUsViewController {
    
    /// Info header section
    /// - Returns: DSSection
    func getInfoHeaderSection() -> DSSection {
        
        // Title
        let title = DSLabelVM(.title2, text: "Best flowers store in town")
        
        // Subtitle
        let subtitle = DSLabelVM(.body ,text: "Here you will feel the attitude, here you will receive quality, here you will see the atmosphere of an authentic flower store")
        
        return [title, subtitle].list()
    }
    
    /// Info description section
    /// - Returns: DSSection
    func getInfoDescriptionSection() -> DSSection {
        
        let text1 = DSLabelVM(.body ,text: faker.text)
        let text3 = DSLabelVM(.body ,text: faker.text)
        let text2 = DSLabelVM(.subheadline ,text: faker.text)
        
        return [text1, text2, text3].list(grouped: true).zeroTopInset()
    }
    
    /// Gallery section
    /// - Returns: DSSection
    func getInfoGallerySection() -> DSSection {
        
        let urls = [URL.topFlowers3,
                    URL.topFlowers2,
                    URL.topFlowers1].compactMap({ $0 })
        
        let pictureModels = urls.map { url -> DSViewModel in
            return DSImageVM(imageUrl: url, height: .absolute(250))
        }
        
        let pageControl = DSPageControlVM(type: .viewModels(pictureModels))
        return pageControl.list().zeroLeftRightInset()
    }
}
