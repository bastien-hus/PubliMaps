//
//  ContentView.swift
//  PubliMaps
//
//  Created by Bastien HUSLER on 10/03/2022.
//

import MapKit
import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = MapViewModel()
    @StateObject private var stationprovider: StationProvider
    @StateObject private var infoprovider: InfoProvider
    @State private var currentstation: Station = Station()
//    @State private var search: String = ""
    @State private var isShowingSheet = false
    
    private var closeststation: Station = Station()
    
    init() {
        _stationprovider = StateObject(wrappedValue: StationProvider())
        _infoprovider = StateObject(wrappedValue: InfoProvider())
    }
    
    var body: some View {
        ZStack(alignment: Alignment.top) {
            Map(coordinateRegion: .constant(viewModel.region), showsUserLocation: true, annotationItems: stationprovider.stations) { station in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: station.latitude, longitude: station.longitude), anchorPoint: CGPoint(x: 0, y: 0)) {
                        Image(systemName: "bicycle.circle.fill")
                        .foregroundColor(Colors[Int(station.state.id) - 1])
                            .onTapGesture {
                                currentstation = station
                                isShowingSheet.toggle()
                            }
                }
                
            }.ignoresSafeArea()
                .onAppear {
                    viewModel.checkIfLocationServicesIsEnabled()
                }
                
//                TextField("Search", text: $search)
//                    .padding(7)
//                    .padding(.horizontal, 25)
//                    .background(Color(.systemGray6))
//                    .cornerRadius(8)
//                    .padding([.leading, .bottom, .trailing], 10)
//                    .padding(.top, 100)

            HStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        viewModel.locationManagerDidChangeAuthorization(viewModel.locationManager!)
                    }
                }) {
                Image(systemName: "location.fill")
                            .symbolRenderingMode(.monochrome)
                            .foregroundColor(Color.accentColor)
                            .font(.system(size: 30))
                }.padding()
            }.padding(.top, 40)
            SearchBar(stationprovider: stationprovider)
        }
        .task {
            await stationprovider.updateStations()
            stationprovider.setClosest(inLocation: viewModel.locationManager?.location)
        }
        .sheet(isPresented: $isShowingSheet) {
            InfoView(info: $infoprovider.currentstation)
                .task {
                    await infoprovider.getInfo(station: currentstation)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
