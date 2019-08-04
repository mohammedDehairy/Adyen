//
//  ViewController.swift
//  Adyen
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import UIKit
import LocationProvider
import ClientAPI
import PlacesScene

class RootViewController: UIViewController {
    lazy var clientApi: ClientAPI = {
        return DefaultAPIClient(executer: URLSession.shared)
    }()
    
    lazy var placesViewModel: PlacesViewModel = {
        let store = RemotePlaceStore(clientApi: clientApi)
        return DefaultPlacesViewModel(
            store: store,
            locationProvider: DefaultLocationProvider()
        )
    }()
    
    lazy var placesViewController: PlacesViewController = {
        return PlacesViewController(viewModel: placesViewModel)
    }()
    
    lazy var naviController: UINavigationController = {
        return UINavigationController(rootViewController: placesViewController)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        naviController.willMove(toParent: self)
        addChild(naviController)
        view.addSubview(naviController.view)
        naviController.didMove(toParent: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        naviController.view.frame = CGRect(origin: .zero, size: view.bounds.size)
    }

}

