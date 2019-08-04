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

public class PlaceAnnotation: MKPointAnnotation {
    var identifier: String?
}

public class PlacesViewController: UIViewController, MKMapViewDelegate {
    private var viewModel: PlacesViewModel
    let mapView: MKMapView = {
        let mapView = MKMapView(frame: CGRect.zero)
        mapView.showsUserLocation = true
        return mapView
    }()
    private let loadButtonIcon: UIImage
    var loadButton: UIButton = {
        UIButton(frame: .zero)
    }()
    private var pins: [MKPointAnnotation] = []
    private var isFirstLoad: Bool = true
    
    public init(viewModel: PlacesViewModel, loadButtonIcon: UIImage) {
        self.viewModel = viewModel
        self.loadButtonIcon = loadButtonIcon
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupMapView()
        setupLoadButton()
        title = "Explore Venus"
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        mapView.frame = CGRect(origin: .zero, size: view.bounds.size)
        
        let buttonOrigin = CGPoint(x: view.bounds.size.width - 60 - view.safeAreaInsets.right, y: view.bounds.size.height - 60 - view.safeAreaInsets.bottom)
        let buttonSize = CGSize(width: 50, height: 50)
        loadButton.frame = CGRect(origin: buttonOrigin, size: buttonSize)
        loadButton.layer.cornerRadius = buttonSize.height * 0.5
    }
    
    // MARK: - Setup the load button
    
    private func setupLoadButton() {
        view.addSubview(loadButton)
        view.bringSubviewToFront(loadButton)
        loadButton.setImage(loadButtonIcon, for: .normal)
        loadButton.backgroundColor = .white
        loadButton.addTarget(self, action: #selector(didTapOnLoad), for: .touchUpInside)
    }
    
    @objc func didTapOnLoad() {
        viewModel.didChangeRegion(region: mapView.region)
    }
    
    // MARK: - Setup Map View
    
    private func setupMapView() {
        view.addSubview(mapView)
        mapView.delegate = self
    }
    
    // MARK: - MKMapViewDelegate
    
    public func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        guard isFirstLoad else { return }
        viewModel.didChangeRegion(region: mapView.region)
    }
    
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
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
    
    public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        guard let place = (viewModel.cachedModel.filter { (annotation as? PlaceAnnotation)?.identifier == $0.id }).first else {
            return
        }
        viewModel.didSelect(place: place)
    }

    // MARK: - Setup View Model
    
    private func setupViewModel() {
        viewModel.updateModel = {[weak self] result in
            self?.handle(result: result)
        }
        viewModel.updateUserLocation = {[weak self] location in
            self?.handle(userLocation: location)
        }
    }
    
    private func handle(userLocation: CLLocation) {
        let initailRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(initailRegion, animated: false)
        viewModel.updateUserLocation = nil
    }
    
    private func handle(result: Result<[PlaceModel], Error>) {
        if let places = result.value {
            handle(places: places)
            isFirstLoad = false
        } else if let error = result.error {
            showError(error: error)
        }
    }
    
    private func handle(places: [PlaceModel]) {
        let newPins = places.map(getPin(from:))
        mapView.removeAnnotations(pins)
        pins = newPins
        mapView.addAnnotations(pins)
        if places.isEmpty {
            showWarning(message: "No Venus found in this area, please try another.")
        }
    }
    
    private func showWarning(message: String) {
        let banner = NotificationBanner(title: message, subtitle: "", style: .warning)
        banner.show()
    }
    
    private func showError(error: Error) {
        let banner = NotificationBanner(title: error.localizedDescription, subtitle: "", style: .danger)
        banner.show()
    }
    
    private func getPin(from place: PlaceModel) -> MKPointAnnotation {
        let pin = PlaceAnnotation()
        pin.coordinate = place.coordinate
        pin.title = place.name
        pin.subtitle = place.category
        pin.identifier = place.id
        return pin
    }
}
