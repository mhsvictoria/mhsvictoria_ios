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
let darkGrey = UIColor(0x9f8d8d)
let light_grey = UIColor(0xd4d4d4)
let unselectedGrey = UIColor(0xe4e4e4)
let accent = UIColor(0xe44a4d)
