//
//  HeadlineView.swift
//  WeatherApp
//
//  Created by Naveen Reddy on 06/09/24.
//

import Foundation
import SwiftUI

struct HeadlineView: View {
    let title: String

    var body: some View {
        Text(title.capitalized)
            .font(.headline)
            .foregroundStyle(Color(.label))
            .padding(.top)
    }
}


struct SubheadlineView: View {
    let title: String

    var body: some View {
        Text(title.capitalized)
            .font(.subheadline)
            .foregroundStyle(Color(.secondaryLabel))
    }
}
