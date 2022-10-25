//
//  InfoView.swift
//  PubliMaps
//
//  Created by Bastien HUSLER on 18/03/2022.
//

import SwiftUI

struct InfoView: View {
    @Binding var info: StationInfo
    
    var body: some View {
        VStack {
            Text(info.name)
                .font(.largeTitle)
                .padding(.top, 40)
            Text(info.address + ", " + info.city)
                .font(.body)
                .padding(.bottom, 30)
            Text("Bikes")
                .font(.title)
                .multilineTextAlignment(TextAlignment.leading)
            
            List {
                ForEach(info.vehicles.sorted(by: sortVehicles)) { section in
                    BikeRow(bike: .constant(section))
                }
            }
        }.frame(maxWidth: .infinity)
    }
    
    private func sortVehicles(v1: Vehicle, v2: Vehicle) -> Bool {
        return v1.type.id == 2 && (v2.type.id != 2 || (v1.ebike_battery_level ?? 0.0) > (v2.ebike_battery_level ?? 0.0))
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(info: .constant(StationInfo()))
    }
}
