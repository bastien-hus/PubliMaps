//
//  RoutingEngine.swift
//  PubliMaps
//
//  Created by Bastien HUSLER on 08/04/2022.
//

import Combine
import CoreLocation
import SwiftUI


class RoutingEngine: ObservableObject {
    
    @Published var nearesttome: Station
    @Published var nearesttodest: Station
    @Published var destination: CLLocationCoordinate2D
    var stationprovider: StationProvider
    
    init(stationprovider: StationProvider) {
        self.destination = CLLocationCoordinate2D()
        self.nearesttome = Station()
        self.nearesttodest = Station()
        self.stationprovider = stationprovider
    }
    
//    func setDestination(location: CLLocation) {
//        nearesttodest = stationprovider.getNearestStation(location: location)
//        destination = location.coordinate
//    }
}
