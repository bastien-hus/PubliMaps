//
//  InfoProvider.swift
//  PubliMaps
//
//  Created by Bastien HUSLER on 17/03/2022.
//

import SwiftUI

@MainActor
class InfoProvider: ObservableObject {
    @Published var currentstation: StationInfo = StationInfo()
    
    
    func getInfo(station: Station) async {
        print(station.id)
        let url = URL(string: "https://api.publibike.ch/v1/public/stations/" + String(station.id))!
        let request = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            let result = try JSONDecoder().decode(StationInfo.self, from: data)
    //        print(result)
            currentstation = result
        } catch let error as LocalizedError  {
            debugPrint(error)
            currentstation = StationInfo()
        } catch {
            fatalError()
        }
    }
    
}
