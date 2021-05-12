//
//  Resource.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-09-25.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import Foundation


public struct Resource: Codable {
    var category: Category
    var name: String
    var location: Location
    var serviceProvider: String?
    var referralNeeded: Bool
    var rapidAccess: Bool
    var minAgeServed: Int = 0
    var maxAgeServed: Int = 120
    var cost: Int = 0
    var identity: [Identity]
    var language: Language?
    var email: String?
    var phoneNumber: String?
    var physicalAddress: String?
    var virtualAddress: String?
    var photoLink: String?
    var description: String?
    

}

public struct StrResource: Codable {
    var category: String?
    var name: String?
    var location: String?
    var serviceProvider: String?
    var referralNeeded: Bool?
    var rapidAccess: Bool?
    var minAgeServed: Int? = 0
    var maxAgeServed: Int? = 120
    var cost: Int? = 0
    var identity: String?
    var language: String?
    var email: String?
    var phoneNumber: String?
    var physicalAddress: String?
    var virtualAddress: String?
    var photoLink: String?
    var description: String?
    

}

enum Category: String, Codable {
    case counselling = "Counselling"
    case crisis = "Crisis"
    case groupPeer = "Group/Peer"
    case healthcare = "Healthcare"
    case wellness = "Wellness"
    case fitnessRecreation = "Fitness/Recreation"
    case alternative = "Alternative"
}

enum Language: String, Codable {
    case english = "English"
}
