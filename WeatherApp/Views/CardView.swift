//
//  CardView.swift
//  WeatherApp
//
//  Created by Naveen Reddy on 06/09/24.
//

import Foundation
import SwiftUI

struct CardView<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .center) {
            content
        }
        .padding()
        .background(.secondary.opacity(0.15))
        .cornerRadius(8)
    }
}
