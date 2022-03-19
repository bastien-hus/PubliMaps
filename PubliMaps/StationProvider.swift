//
//  StationProvider.swift
//  PubliMaps
//
//  Created by Bastien HUSLER on 14/03/2022.
//

import SwiftUI
import Foundation

@MainActor
class StationProvider: ObservableObject {
    @Published var stations: [Station] = []
    
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
}
