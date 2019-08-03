//
//  PlacesViewController.swift
//  Adyen
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import UIKit
import MapKit
import NotificationBannerSwift

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
        title = "Explore Venus"
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        let identifier = "MyCustomAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if let view = annotationView {
            view.annotation = annotation
        } else {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        return annotationView
    }

    // MARK: - Setup View Model
    
    private func setupViewModel() {
        viewModel.updateModel = {[weak self] result in
            self?.handle(result: result)
        }
    }
    
    private func handle(result: Result<[PlaceModel], Error>) {
        if let places = result.value {
            let newPins = places.map(getPin(from:))
            mapView.removeAnnotations(pins)
            pins = newPins
            mapView.addAnnotations(pins)
        } else if let error = result.error {
            showError(error: error)
        }
    }
    
    private func showError(error: Error) {
        let banner = NotificationBanner(title: error.localizedDescription, subtitle: "", style: .danger)
        banner.show()
    }
    
    private func getPin(from place: PlaceModel) -> MKPointAnnotation {
        let pin = MKPointAnnotation()
        pin.coordinate = place.coordinate
        pin.title = place.name
        pin.subtitle = place.category
        return pin
    }
}
