//
//  BikeRow.swift
//  PubliMaps
//
//  Created by Bastien HUSLER on 18/03/2022.
//

import SwiftUI

struct BikeRow: View {
    @Binding var bike: Vehicle
    
    var body: some View {
        HStack {
            if bike.type.id == 2 {
                if bike.ebike_battery_level ?? 0 >= 80.0 {
                    Image(systemName: "battery.100")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.green, Color.primary)
                } else if bike.ebike_battery_level ?? 0 >= 60.0 {
                    Image(systemName: "battery.75")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.green, Color.primary)
                } else if bike.ebike_battery_level ?? 0 >= 40.0 {
                    Image(systemName: "battery.50")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.green, Color.primary)
                } else if bike.ebike_battery_level ?? 0 >= 20.0 {
                    Image(systemName: "battery.25")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.green, Color.primary)
                } else {
                    Image(systemName: "battery.0")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.primary)
                }
            } else {
                Image(systemName: "bicycle")
                    .foregroundColor(Color.accentColor)
            }
            Spacer()
            Text(bike.name)
            Spacer()
            if bike.ebike_battery_level != nil {
                Text(String(format: "%.0f", bike.ebike_battery_level!) + " %")
            } else {
                Text("         ")
            }
        }.padding()
    }
}

struct BikeRow_Previews: PreviewProvider {
    static var previews: some View {
        BikeRow(bike: .constant(Vehicle()))
    }
}
