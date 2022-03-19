//
//  ContentView.swift
//  PubliMaps
//
//  Created by Bastien HUSLER on 10/03/2022.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 47.36667, longitude: 8.55), span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15))
    
    @StateObject private var stationprovider: StationProvider
    @State private var currentstation: Station = Station()
    @State private var currentinfo = StationInfo()
    @State private var search: String = ""
    @State private var isShowingSheet = false
    
    init() {
        _stationprovider = StateObject(wrappedValue: StationProvider())
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: Alignment.top) {
                Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: stationprovider.stations) { station in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: station.latitude, longitude: station.longitude), anchorPoint: CGPoint(x: 0, y: 0)) {
                            Image(systemName: "bicycle.circle.fill")
                                .foregroundColor(Color(.systemPurple))
                                .onTapGesture {
                                    currentstation = station
                                    isShowingSheet.toggle()
                                }
                    }
                }
                
                SearchBar(search: $search)
                    .padding(.top, 40)
                
            }.edgesIgnoringSafeArea(.vertical)
                .sheet(isPresented: $isShowingSheet) {
                    InfoView(info: $currentinfo)
                        .task {
                            currentinfo = await getInfo(station: currentstation)
                        }
                }
        }
        .task {
            await stationprovider.updateStations()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
