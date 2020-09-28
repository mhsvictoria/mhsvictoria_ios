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
let margin: CGFloat = 20
let marginMedLrg: CGFloat = 40
let marginLrg: CGFloat = 80
let cornerRadius: CGFloat = 10
let toolbarHeight: CGFloat = 100
let toolbarOffset: CGFloat = 60
let headerHeight: CGFloat = 60

// constants for circular tabs
let buttonSize: CGFloat = 40
let buttonBorderWidth: CGFloat = 1
let lineHeight: Int = 10
let lineWidth: CGFloat = 2
// Once the number of forms is nailed down
// we can update these values to match
enum FormFlow: Int {
    case age = 0 /* default is 0 */, description, resourcePreference, end
}
