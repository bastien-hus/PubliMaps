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
                Text("🔋")
            } else {
                Text("🚲")
            }
            Spacer()
            Text(bike.name)
            Spacer()
            Text(String(format: "%.0f", bike.ebike_battery_level) + " %")
        }.padding()
    }
}

struct BikeRow_Previews: PreviewProvider {
    static var previews: some View {
        BikeRow(bike: .constant(Vehicle()))
    }
}
