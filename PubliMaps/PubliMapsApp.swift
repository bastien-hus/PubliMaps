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

struct stateStruct : Decodable, Equatable {
    let id: Int32
    let name: String
    
    init() {
        self.id = 0
        self.name = "Some State"
    }
}

struct Station: Decodable, Equatable, Identifiable {
    let id: Int32
    let latitude: Double
    let longitude: Double
    let state: stateStruct
    
    init() {
        self.id = 0
        self.latitude = 0
        self.longitude = 0
        self.state = stateStruct()
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
    let ebike_battery_level: Double
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

@MainActor
func getInfo(station: Station) async -> StationInfo {
    print(station.id)
    let url = URL(string: "https://api.publibike.ch/v1/public/stations/" + String(station.id))!
    let request = URLRequest(url: url)
    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        print("responded")
        let result = try JSONDecoder().decode(StationInfo.self, from: data)
        return result
    } catch let error as LocalizedError  {
        print(error.localizedDescription)
        return StationInfo()
    } catch {
        fatalError()
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
