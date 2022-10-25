
//
//  ContentViewModel.swift
//  AppleLocalSearch
//
//  Created by Robin Kment on 13.10.2020.
//
import Foundation
import MapKit
import Combine

struct LocalSearchViewData: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var location: CLLocation
    
    init(mapItem: MKMapItem) {
        self.title = mapItem.name ?? ""
        self.subtitle = mapItem.placemark.title ?? ""
        self.location = mapItem.placemark.location ?? CLLocation()
    }
}
