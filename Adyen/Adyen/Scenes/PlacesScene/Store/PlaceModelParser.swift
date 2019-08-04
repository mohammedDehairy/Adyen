//
//  PlaceModelParser.swift
//  Adyen
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import MapKit

enum ParsingError: LocalizedError {
    case nilData
    case invalidJson
    case noCategoriesObject
    case noErrorDetails
    case apiError(message: String)
    
    public var errorDescription: String? {
        switch self {
        case .apiError(let message):
            return message
        default:
            return "Fatal Error: Unexpected Server response"
        }
    }
}

func parse(data: Data?) -> Result<[PlaceModel], Error> {
    guard let data = data else {
        assertionFailure("Invalid data")
        return .failure(ParsingError.nilData)
    }
    guard let jsonObject = try? JSONDecoder().decode(APIJsonObject.self, from: data) else {
        assertionFailure("Invalid json")
        return .failure(ParsingError.invalidJson)
    }
    let response = jsonObject.response
    let meta = jsonObject.meta
    guard let groups = response.groups else {
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

private func parse(meta: Meta) -> Result<[PlaceModel], Error> {
    let code = meta.code
    if code != 200 {
        guard let errorDetail = meta.errorDetail else {
            assertionFailure("Invalid json")
            return .failure(ParsingError.noErrorDetails)
        }
        return .failure(ParsingError.apiError(message: errorDetail))
    }
    return .success([])
}

private func parse(group: Group) -> Result<[PlaceModel], Error> {
    let items = group.items
    let places: [PlaceModel] = items.reduce([]) { result, item in
        guard let place = parse(item: item).value else { return result }
        var result = result
        result.append(place)
        return result
    }
    return .success(places)
}

private func parse(item: Item) -> Result<PlaceModel, Error> {
    let venu = item.venue
    let id = venu.id
    let name = venu.name
    let location = venu.location
    let latitude = location.lat
    let longitude = location.lng
    let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    guard let category = venu.categories.first else {
        assertionFailure("Invalid json")
        return .failure(ParsingError.noCategoriesObject)
    }
    let categoryName = category.name
    return .success(PlaceModel(id: id, name: name, coordinate: coordinate, category: categoryName))
}
