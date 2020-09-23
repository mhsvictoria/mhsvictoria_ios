//
//  Constants.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-09-12.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit

let ageKey = "age"
let defaultAge = 25
let sliderDivisor: Float = 100
let marginTiny: CGFloat = 4
let marginSmall: CGFloat = 10
let margin: CGFloat = 20
let marginMedLrg: CGFloat = 40
let marginLrg: CGFloat = 80
let cornerRadius: CGFloat = 10
let toolbarHeight: CGFloat = 100
let toolbarOffset: CGFloat = 72
let controlBarHeight: CGFloat = 64
let headerHeight: CGFloat = 36
let pageControlHeight: CGFloat = 44
let textFieldHeight: CGFloat = 38

// Once the number of forms is nailed down
// we can update these values to match
enum FormFlow: Int {
    case age = 0 /* default is 0 */, description, resourcePreference, end
}
