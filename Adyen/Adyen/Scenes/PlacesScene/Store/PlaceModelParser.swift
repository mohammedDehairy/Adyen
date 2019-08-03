//
//  PlaceModelParser.swift
//  Adyen
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import MapKit

enum ParsingError: Error {
    case nilData
    case invalidJson
    case noResponseObject
    case noItemsObject
    case noVenuObject
    case noVenuId
    case noVenuName
    case noLocationObject
    case noLat
    case noLng
    case noStatusCode
    case noErrorDetails
    case apiError(message: String)
    case noMetaObject
}

func parse(data: Data?) -> Result<[PlaceModel], Error> {
    guard let data = data else {
        assertionFailure("Invalid data")
        return .failure(ParsingError.nilData)
    }
    guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
        assertionFailure("Invalid json")
        return .failure(ParsingError.invalidJson)
    }
    guard let response = json["response"] as? [String: Any] else {
        assertionFailure("Invalid json")
        return .failure(ParsingError.noResponseObject)
    }
    guard let meta = json["meta"] as? [String: Any] else {
        assertionFailure("Invalid json")
        return .failure(ParsingError.noMetaObject)
    }
    guard let groups = response["groups"] as? [[String: Any]] else {
        return parse(meta: meta)
    }
    let places: [PlaceModel] = groups.reduce([]) { result, group in
        guard let places = parse(group: group).value else { return result }
        var result = result
        result.append(contentsOf: places)
        return result
    }
    return .success(places)
}

private func parse(meta: [String: Any]) -> Result<[PlaceModel], Error> {
    guard let code = meta["code"] as? Int else {
        assertionFailure("Invalid json")
        return .failure(ParsingError.noStatusCode)
    }
    if code != 200 {
        guard let errorDetail = meta["errorDetail"] as? String else {
            assertionFailure("Invalid json")
            return .failure(ParsingError.noErrorDetails)
        }
        return .failure(ParsingError.apiError(message: errorDetail))
    }
    return .success([])
}

private func parse(group: [String: Any]) -> Result<[PlaceModel], Error> {
    guard let items = group["items"] as? [[String: Any]] else {
        assertionFailure("Invalid json")
        return .failure(ParsingError.noItemsObject)
    }
    let places: [PlaceModel] = items.reduce([]) { result, item in
        guard let place = parse(item: item).value else { return result }
        var result = result
        result.append(place)
        return result
    }
    return .success(places)
}

private func parse(item: [String: Any]) -> Result<PlaceModel, Error> {
    guard let venu = item["venue"] as? [String: Any] else {
        assertionFailure("Invalid json")
        return .failure(ParsingError.noVenuObject)
    }
    guard let id = venu["id"] as? String else {
        assertionFailure("Invalid json")
        return .failure(ParsingError.noVenuId)
    }
    guard let name = venu["name"] as? String else {
        assertionFailure("Invalid json")
        return .failure(ParsingError.noVenuName)
    }
    guard let locationDic = venu["location"] as? [String: Any] else {
        assertionFailure("Invalid json")
        return .failure(ParsingError.noLocationObject)
    }
    guard let latitude = locationDic["lat"] as? Double else {
        assertionFailure("Invalid json")
        return .failure(ParsingError.noLat)
    }
    guard let longitude = locationDic["lng"] as? Double else {
        assertionFailure("Invalid json")
        return .failure(ParsingError.noLng)
    }
    let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    return .success(PlaceModel(id: id, name: name, coordinate: coordinate))
}
