//
//  LocationRepository.swift
//  itinerary-app
//
//  Created by jhou on 11/11/23.
//
struct CityDestination: Codable, Hashable {
//  var id: String
  var name: String
  var latitude: Double
  var longitude: Double
  var weather: String?
  var cityType: [String]
  var continent: String?
  var id: String?
  
  enum CodingKeys: String, CodingKey {
    case name
    case latitude
    case longitude
    case weather
    case cityType
    case continent
  }
  
  func hash(into hasher: inout Hasher) {
      hasher.combine(name)
  }
}


//var duration: Int?


import Foundation
import Combine
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import SwiftUI
// import Firebase modules here

class LocationRepository: ObservableObject {
  // Set up properties here
  static let locationRepository = LocationRepository()
  private let path: String = "cityDestinations"
  private let store = Firestore.firestore()
  @Published var cityDestinations: [CityDestination] = []
//  @Published var currentItinerary: Itinerary? = nil
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    self.get()
  }
  
    func get() {
      store.collection(path)
        .addSnapshotListener { querySnapshot, error in
          if let error = error {
            print("Error getting itineraries: \(error.localizedDescription)")
            return
          }
  
          self.cityDestinations = querySnapshot?.documents.compactMap { document in
            try? document.data(as: CityDestination.self)
          } ?? []
        }
    }
  
  func mapDestinations(quiz: Quiz) -> Dictionary<CityDestination, Int> {
    var destinationPoints: Dictionary<CityDestination, Int> = Dictionary<CityDestination, Int>()
//    Enum.GetValues(typeof(Continent))
    for continent in Continent.allCases {
      quiz.continentMatching[continent.toString()] = []
    }
    for weather in Weather.allCases {
      quiz.weatherMatching[weather.rawValue] = []
    }
    for cityType in CityType.allCases {
      quiz.cityTypeMatching[cityType.toString()] = []
    }
    for destination in cityDestinations {
        quiz.continentMatching[destination.continent ?? "Asia"]?.append(destination)
        quiz.weatherMatching[destination.weather ?? "cold"]?.append(destination)
      for type in destination.cityType {
        quiz.cityTypeMatching[type]?.append(destination)
      }
      destinationPoints[destination] = 0
    }
    return destinationPoints
  }
  
//  func current() {
//    for itinerary in itineraries {
//      if itinerary.isCurrent {
//        currentItinerary = itinerary
//      }
//    }
//  }
}
