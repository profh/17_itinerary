//
//  CustomBackgroundView.swift
//  itinerary-app
//
//  Created by Mitun Adenuga on 11/4/23.
//

// This file contains variables for all the colors created in the Assets
import SwiftUI

struct CustomBackgroundView: View {
    var body: some View {
        ZStack {
            Color.customGreenDark
                .cornerRadius(40)
                .offset(y:12)
            
            //  mark: -2. light
            Color.customGreenDark
                .cornerRadius(40)
                .offset(y: 3)
                .opacity(0.85)
            // mark
            
            LinearGradient(colors: [
                .customGreenMedium,
                .customGreenLight], startPoint: .top, endPoint: .bottom)
            .cornerRadius(40)
        }
    }
}

#Preview {
    CustomBackgroundView()
}
