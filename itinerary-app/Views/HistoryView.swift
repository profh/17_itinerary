//
//  HistoryView.swift
//  itinerary-app
//
//  Created by jhou on 11/1/23.
//

import SwiftUI

struct HistoryView: View {
  @ObservedObject var itineraryRepository = ItineraryRepository.itineraryRepository
  var body: some View {
    let itineraries = itineraryRepository.itineraries.sorted()
    let current = itineraryRepository.currentItinerary
    NavigationView {
      VStack(alignment: .leading) {
        Text("Current Itinerary").font(.title2).fontWeight(.bold)
        if let current {
          ItineraryNavView(itinerary: current, isCurrent: true, saved: true/*, itineraryRepository: self.itineraryRepository*/)
        }
        else {
          ZStack {
            // Gradient on top of the image
            Rectangle()
                .fill(lightBlueColor)
                .frame(width: 340, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            // Text within the button
            HStack {
              Text("Set an itinerary as your current one!").frame(alignment: .leading)
                .fontWeight(.bold).foregroundColor(Color.white)
                .font(.title3)
            }.padding(10)
              Spacer()
          }.frame(maxWidth: 340, maxHeight: 200, alignment: .leading)
        }
        Spacer(minLength: 20)
        Text("Past Itineraries").font(.title2).frame(alignment:.leading).fontWeight(.bold)
        ScrollView(.vertical) {
          ForEach(itineraries) { itinerary in
            if (!itinerary.isCurrent) {
              ItineraryNavView(itinerary: itinerary, isCurrent: false, saved: true/*, itineraryRepository: self.itineraryRepository*/)
            }
          }
        }.frame(alignment: .leading)
      }
    }
  }
}

#Preview {
    HistoryView(itineraryRepository: ItineraryRepository())
}
