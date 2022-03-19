//
//  Handle.swift
//  PubliMaps
//
//  Created by Bastien HUSLER on 17/03/2022.
//

import SwiftUI

struct Handle : View {
    private let handleThickness = CGFloat(5.0)
    var body: some View {
        RoundedRectangle(cornerRadius: handleThickness / 2.0)
            .frame(width: 40, height: handleThickness)
            .foregroundColor(Color.secondary)
            .padding(5)
    }
}
