//
//  MapViewRepresentable.swift
//  UniRoute
//
//  Created by Sherren Jie on 10/12/24.
//

import SwiftUI
import UIKit
import GoogleMaps

struct MapViewRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MapViewController {
        return MapViewController()
    }
    
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        
    }
    
    // Optionally, you can add methods to manage the interaction between your SwiftUI view and the UIKit view controller.
    typealias UIViewControllerType = MapViewController
}

