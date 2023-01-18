//
//  LoaderView.swift
//  WeatherApp
//
//  Created by hope on 1/13/23.
//

import SwiftUI

struct LoaderView: View {
    var tintColor: Color = .gray
    var scaleSize: CGFloat = 1
    
    var body: some View {
        ProgressView()
            .scaleEffect(scaleSize, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: tintColor))
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}
