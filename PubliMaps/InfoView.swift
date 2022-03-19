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
                ForEach(info.vehicles) { section in
                    BikeRow(bike: .constant(section))
                }
            }
        }.frame(maxWidth: .infinity)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(info: .constant(StationInfo()))
    }
}
