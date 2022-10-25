//
//  PubliMapsApp.swift
//  PubliMaps
//
//  Created by Bastien HUSLER on 10/03/2022.
//
import UIKit
import Foundation
import SwiftUI
import MapKit

let Colors = [Color(.systemGreen), Color(.systemRed), Color(.systemOrange)]

struct stateStruct : Decodable, Equatable {
    let id: Int32
    let name: String
    
    init() {
        self.id = 0
        self.name = "Some State"
    }
}

struct Station: Decodable, Equatable, Identifiable, CustomStringConvertible {
    let id: Int32
    let latitude: Double
    let longitude: Double
    let state: stateStruct
    
    public var description: String { return "\(self.id)"}
    
    init() {
        self.id = 0
        self.latitude = 0
        self.longitude = 0
        self.state = stateStruct()
    }
    
    func getCoordinates() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
    
    func toLocation() -> CLLocation {
        return CLLocation(latitude: self.latitude, longitude: self.longitude)
    }
    
    func toString() -> String {
        return "\(self.id)"
    }
}

struct biketype: Decodable {
    let id: Int32
    let name: String
    
    init() {
        self.id = 2
        self.name = "E-Bike"
    }
}

struct Vehicle: Decodable, Identifiable {
    let ebike_battery_level: Double?
    let id: Int32
    let name: String
    let type: biketype
    
    init() {
        self.ebike_battery_level = 58.0
        self.id = 4373
        self.name = "503248"
        self.type = biketype()
    }
}

struct StationInfo: Decodable {
    let name: String
    let address: String
    let city: String
    let vehicles: [Vehicle]
    
    init() {
        self.name = "Some Name"
        self.address = "Some Address"
        self.city = "Some City"
        self.vehicles = []
    }
}

@main
struct PubliMapsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
