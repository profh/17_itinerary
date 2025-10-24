//
//  ItineraryListView.swift
//  itinerary-app
//
//  Created by jhou on 10/23/23.
//

import Foundation
import SwiftUI

struct ItineraryListView: View {
  @ObservedObject var itineraryRepository = ItineraryRepository()
  
  var body: some View {
    
    let itineraries = itineraryRepository.itineraries.sorted()
    NavigationView {
      List {
        ForEach(itineraries) { itinerary in
          ItineraryNavView(itinerary: itinerary, sizeHeight: 100, isCurrent: false)
        }
      }
    }
  }
}
