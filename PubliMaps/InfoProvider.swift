//
//  InfoProvider.swift
//  PubliMaps
//
//  Created by Bastien HUSLER on 17/03/2022.
//

import SwiftUI
import Foundation


class InfoProvider: ObservableObject {
    @Published var currentstation: StationInfo? = nil
    
    
    
    func updateCurrent(station: Station) async {
        let fetched = await getInfo(station: station)
        currentstation = fetched
    }
    
    
}
