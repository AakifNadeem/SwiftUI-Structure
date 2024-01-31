//
//  CheckBoxToggle.swift
//
//  Created by Aakif Nadeem on 26/01/2023.
//

import Foundation
import SwiftUI

struct CheckboxStyle: ToggleStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .black : .gray)
            configuration.label
        }
        .onTapGesture { configuration.isOn.toggle() }
    }
}
