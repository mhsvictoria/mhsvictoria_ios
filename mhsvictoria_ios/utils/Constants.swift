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
let imageSize: CGFloat = 24
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
let buttonWidth: CGFloat = 64
let buttonHeight: CGFloat = 32
let dataDownloadUrl = "https://docs.google.com/spreadsheets/d/e/2PACX-1vQY1_edinIsVnPAQMlu2d_L8EmjNNOQ9qS869Nbi4S215_EOMyTrggowKNAjL8b6e9nK_BAmZmAyQjS/pub?output=csv"

// constants for circular tabs
let buttonSize: CGFloat = 40
let buttonBorderWidth: CGFloat = 1
let lineHeight: Int = 10
let lineWidth: CGFloat = 2


// constants for resource detail page
let mapViewHeight: CGFloat = 200
let mapViewWidth: CGFloat = 200
let iconViewHeight: CGFloat = 50

// Once the number of forms is nailed down
// we can update these values to match
enum FormFlow: Int {
    case age = 0 /* default is 0 */, description, resourcePreference, end
}
