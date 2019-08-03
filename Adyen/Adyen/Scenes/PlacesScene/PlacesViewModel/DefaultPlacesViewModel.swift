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
    
    var updateModel: (([PlaceModel]) -> Void)?
    
    init(store: PlaceStore) {
        self.store = store
    }
    
    func didChangeRegion(region: MKCoordinateRegion) {
        currentQuery?.cancel()
        let query = PlaceQuery(region: region)
        currentQuery = store.get(with: query) {[weak self] result in
            self?.handle(result: result)
            self?.currentQuery = nil
        }
    }
    
    private func handle(result: Result<[PlaceModel], Error>) {
        guard let places = result.value else { return }
        cachedModel = places
        updateModel?(cachedModel)
    }
    
    func didSelect(place: PlaceModel) {
        
    }
    
    func didSelectPlace(at index: Int) {
        
    }
}
