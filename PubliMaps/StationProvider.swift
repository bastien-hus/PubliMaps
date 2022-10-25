//
//  StationProvider.swift
//  PubliMaps
//
//  Created by Bastien HUSLER on 14/03/2022.
//

import SwiftUI
import MapKit

@MainActor
class StationProvider: ObservableObject {
    @Published var stations: [Station] = []
    var availablestations: [Station] = []
    @Published var closeststation = Station()
    @Published var destinationstation = Station()
    @Published var destination = CLLocationCoordinate2D()
    
    private func getStations() async -> [Station] {
        let url = URL(string: "https://api.publibike.ch/v1/public/stations")!
        let request = URLRequest(url: url)
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let result = try JSONDecoder().decode([Station].self, from: data)
            return result
        } catch {
            print("error")
            fatalError()
        }
    }
    
    func updateStations() async {
        let fetched = await getStations()
        stations = fetched
    }
    
    private func getNearestStation(needBike: Bool, location: CLLocation) -> Station {
        if !stations.isEmpty {
            if needBike {
                guard let closest = stations.filter({$0.state.id == 1}).min(by: {location.distance(from: $0.toLocation()) < location.distance(from: $1.toLocation()) }) else { return Station() }
                return closest
            } else {
                guard let closest = stations.filter({$0.state.id == 1 || $0.state.id == 3}).min(by: {location.distance(from: $0.toLocation()) < location.distance(from: $1.toLocation()) }) else { return Station() }
                return closest
            }
        } else {
            print("Station array is empty")
            return Station()
        }
    }
    
    func setDestination(inLocation: CLLocation?) {
        guard let location = inLocation else { return }
        destinationstation = getNearestStation(needBike: false, location: location)
        destination = location.coordinate
    }
    
    func setClosest(inLocation: CLLocation?) {
        guard let location = inLocation else { return }
        closeststation = getNearestStation(needBike: true, location: location)
    }
}
