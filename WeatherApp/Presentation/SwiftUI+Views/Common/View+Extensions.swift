//
//  View+Extensions.swift
//  WeatherApp
//
//  Created by hope on 1/13/23.
//

import Foundation
import SwiftUI

extension Image {
    init(data: Data?, placeholder: String? = nil) {
        guard let data = data, let uiImage = UIImage(data: data) else {
            if let placeholder = placeholder {
                self = Image(placeholder)
            } else {
                self = Image(uiImage: UIImage())
            }
            return
        }
        self = Image(uiImage: uiImage)
    }
    
    func iconModifier(size: CGFloat = 32) -> some View {
        resizable()
            .scaledToFit()
            .frame(width: size)
    }
}

extension View {
    @ViewBuilder func visible(_ status: Bool) -> some View {
        switch status {
        case true: self
        case false: self.hidden()
        }
    }
}
