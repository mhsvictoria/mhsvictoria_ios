//
//  Resource.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-09-25.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import Foundation
import AppointmentKit

struct Resource : Entity {
    var id: String
    var name: String
    var category: String
    var addressLocation: Location?
    var billingLocation: Location?
    var contact: Contact?
}
