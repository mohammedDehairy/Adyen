//
//  DefaultPlacesViewModel.swift
//  Adyen
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import MapKit

final class DefaultPlacesViewModel: PlacesViewModel {    
    private let store: PlaceStore
    private(set) var cachedModel: [PlaceModel] = []
    private var currentQuery: Cancelable?
    private var locationProvider: LocationProvider
    
    var updateModel: ((Result<[PlaceModel], Error>) -> Void)?
    var updateUserLocation: ((CLLocation) -> Void)? {
        didSet {
            locationProvider.updateUserLocation = updateUserLocation
            if updateUserLocation != nil {
                locationProvider.startUpdateLocation()
            } else {
                locationProvider.stopUpdateLocation()
            }
        }
    }
    
    init(store: PlaceStore, locationProvider: LocationProvider) {
        self.store = store
        self.locationProvider = locationProvider
    }
    
    func didChangeRegion(region: MKCoordinateRegion) {
        currentQuery?.cancel()
        let query = PlaceQuery(region: region, limit: 60)
        currentQuery = store.get(with: query) {[weak self] result in
            self?.handle(result: result)
            self?.currentQuery = nil
        }
    }
    
    private func handle(result: Result<[PlaceModel], Error>) {
        // Ignore the error returned when the query is canceled
        guard (result.error as NSError?)?.code != NSURLErrorCancelled else { return }
        if let places = result.value {
            cachedModel = places
        }
        updateModel?(result)
    }
    
    func didSelect(place: PlaceModel) {
        
    }
}
