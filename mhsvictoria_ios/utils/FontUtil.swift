//
//  FontUtil.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-09-16.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit

let sectionHeaderFont = UIFont(name: "HelveticaNeue-Italic", size: 14.0)

let fontName = "Arial"
// 13, 14, 15, 16, 18, 20, 24, 36
let fontSizeSmall: CGFloat = 13
let fontSizeMed: CGFloat = 15
let fontSizeMedLarge: CGFloat = 18
let fontSizeLarge: CGFloat = 20
let fontSizeExtraLarge: CGFloat = 24
let fontSizeHuge: CGFloat = 36

let buttonFont = UIFont(name: "Helvetica", size: fontSizeMedLarge)

extension UIFont {
    
    var bold: UIFont {
        return with(traits: .traitBold)
    } // bold
    
    var italic: UIFont {
        return with(traits: .traitItalic)
    } // italic
    
    var boldItalic: UIFont {
        return with(traits: [.traitBold, .traitItalic])
    } // boldItalic
    
    
    func with(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(traits) else {
            return self
        } // guard
        
        return UIFont(descriptor: descriptor, size: 0)
    } // with(traits:)
} // extension
