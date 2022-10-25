//
//  LocalSearchViewModel.swift
//  PubliMaps
//
//  Created by Bastien HUSLER on 08/04/2022.
//

import Foundation
import MapKit
import Combine


final class LocalSearchViewModel: ObservableObject {
    private var cancellable: AnyCancellable?

//    @Published var cityText = "" {
//        didSet {
//            searchForCity(text: cityText)
//        }
//    }
    
    @Published var poiText = "" {
        didSet {
            searchForLocation(text: poiText)
        }
    }
    
    @Published var viewData = [LocalSearchViewData]()
    
    var service: LocalSearchService
        
    init() {
//        Zürich
        let center = CLLocationCoordinate2D(latitude: 47.36667, longitude: 8.55)
        service = LocalSearchService(in: center)
        
        cancellable = service.localSearchPublisher.sink { mapItems in
            self.viewData = mapItems.map({ LocalSearchViewData(mapItem: $0) })
        }
    }
        
//    private func searchForCity(text: String) {
//        service.searchCities(searchText: text)
//    }
    
    private func searchForLocation(text: String) {
        service.searchLocation(searchText: text)
    }
}
