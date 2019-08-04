//
//  APIJsonObject.swift
//  Adyen
//
//  Created by mohamed mohamed El Dehairy on 8/4/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import Foundation
import MapKit

struct APIJsonObject: Codable {
    let meta: Meta
    let response:  Response
}

struct Meta: Codable {
    let code: Int
    let errorDetail: String?
}

struct Response: Codable {
    let groups: [Group]?
}

struct Group: Codable {
    let items: [Item]
}

struct Item: Codable {
    let venue: Venu
}

struct Venu: Codable {
    let id: String
    let name: String
    let location: Location
    let categories: [Category]
}

struct Location: Codable {
    let lat: Double
    let lng: Double
}

struct Category: Codable {
    let name: String
}
