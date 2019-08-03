//
//  PlacesViewController.swift
//  Adyen
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import UIKit
import MapKit

class PlacesViewController: UIViewController, MKMapViewDelegate {
    private var viewModel: PlacesViewModel
    private let mapView: MKMapView = {
        let mapView = MKMapView(frame: CGRect.zero)
        mapView.showsUserLocation = true
        return mapView
    }()
    private var pins: [MKPointAnnotation] = []
    
    init(viewModel: PlacesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupMapView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = CGRect(origin: .zero, size: view.bounds.size)
    }
    
    // MARK: - Setup Map View
    
    private func setupMapView() {
        view.addSubview(mapView)
        mapView.delegate = self
    }
    
    // MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        viewModel.didChangeRegion(region: mapView.region)
    }

    // MARK: - Setup View Model
    
    private func setupViewModel() {
        viewModel.updateModel = {[weak self] places in
            self?.handle(places: places)
        }
    }
    
    private func handle(places: [PlaceModel]) {
        let newPins = places.map(getPin(from:))
        mapView.removeAnnotations(pins)
        pins = newPins
        mapView.addAnnotations(pins)
    }
    
    private func getPin(from place: PlaceModel) -> MKPointAnnotation {
        let pin = MKPointAnnotation()
        pin.coordinate = place.coordinate
        pin.title = place.name
        return pin
    }
    
    // MARK: -
}
