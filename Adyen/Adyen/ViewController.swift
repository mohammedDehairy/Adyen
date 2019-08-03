//
//  ViewController.swift
//  Adyen
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var clientApi: APIClient = {
        return DefaultAPIClient(executer: URLSession.shared)
    }()
    
    lazy var placesViewModel: PlacesViewModel = {
        let store = RemotePlaceStore(clientApi: clientApi)
        return DefaultPlacesViewModel(store: store)
    }()
    
    lazy var placesViewController: PlacesViewController = {
        return PlacesViewController(viewModel: placesViewModel)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placesViewController.willMove(toParent: self)
        addChild(placesViewController)
        view.addSubview(placesViewController.view)
        placesViewController.didMove(toParent: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        placesViewController.view.frame = CGRect(origin: .zero, size: view.bounds.size)
    }

}

