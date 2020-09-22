//
//  ColorPalette.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-08-07.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit

extension  UIColor{
    convenience init(_ hex: UInt) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

let backgroundColor = UIColor(0x225c77)
let toolbarColor = UIColor(0xcfdee5)
let primaryVariantDark = UIColor(0xbeded5)
let primaryVariantLight = UIColor(0xdefef5)
let primaryVariant = toolbarColor

// Background
let backgroundWhite = UIColor(0xFFFFFF)
let background = UIColor(0xFAFAFA)

// Indigo 500
let indigo = UIColor(0x3F51B5)
let indigoVariantDark = UIColor(0x303F9F)
let indigoVariantLight = UIColor(0x9FA8DA)

// PRIMARY
// Teal 500
// teal: 009688
let primary = UIColor(0x008896)
// 0x009688AA
let primaryAlpha = UIColor(0x009688AA)

// SECONDARY
// Teal A100
// 0xA7FFEB
let secondary = UIColor(0xA7EBFF)
// Teal A400
// 0x1DE9B6
let secondaryDark = UIColor(0x1DB6E9)

let accent = UIColor(0xAFFFEF)

// Red 200
let error = UIColor(0xE57373)

let textDark = UIColor(displayP3Red: 68.0/255.0, green: 68.0/255.0, blue: 68.0/255.0, alpha: 1)

let textLight = UIColor(displayP3Red: 112.0/255.0, green: 112.0/255.0, blue: 112.0/255.0, alpha: 1)

let inactive = UIColor(displayP3Red: 0.7, green: 0.7, blue: 0.7, alpha: 1)
