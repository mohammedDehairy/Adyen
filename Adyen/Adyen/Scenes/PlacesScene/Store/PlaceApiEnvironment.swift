//
//  PlaceApiEnvironment.swift
//  Adyen
//
//  Created by mohamed mohamed El Dehairy on 8/4/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import Foundation

struct PlaceApiEnvironment {
    static let `default` = PlaceApiEnvironment(
        host: "https://api.foursquare.com",
        credentials: PlaceApiCredentials(
            id: "11UWH4D0OHIDVOIL2F1NC5OUABVEED3VTOEOVLSPGHI3LKQB",
            secret: "B4RQ2D3CI0ZVQFM5C2OJKH5IN01MX3GJSMO0PT5A0RY0RLDZ"
        )
    )
    let host: String
    let credentials: PlaceApiCredentials
}

struct PlaceApiCredentials {
    let id: String
    let secret: String
}
