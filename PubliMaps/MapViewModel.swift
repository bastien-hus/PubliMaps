//
//  MapViewModel.swift
//  PubliMaps
//
//  Created by Bastien HUSLER on 02/04/2022.
//
import MapKit

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 47.36667, longitude: 8.55)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.defaultSpan)
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("Not enabled")
        }
    }
    
    private func checkLocationAuthorization() {
        guard locationManager != nil else { return }
        
        switch locationManager?.authorizationStatus {
            case .notDetermined:
                locationManager?.requestWhenInUseAuthorization()
            case .restricted:
                print("restricted")
            case .denied:
                print("denied")
            case .authorizedAlways, .authorizedWhenInUse:
                region = MKCoordinateRegion(center: locationManager!.location!.coordinate, span: MapDetails.defaultSpan)
            case .none, .some(_):
                break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
