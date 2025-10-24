//
//  ItineraryRepository.swift
//  itinerary-app
//
//  Created by jhou on 10/17/23.
//

import Combine
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
// import Firebase modules here

class ItineraryRepository: ObservableObject {
  // Set up properties here
  static let itineraryRepository = ItineraryRepository()
  private let path: String = "itineraries"
  private let store = Firestore.firestore()
  @Published var itineraries: [Itinerary] = []
  @Published var currentItinerary: Itinerary? = nil
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
  
          self.itineraries = querySnapshot?.documents.compactMap { document in
            try? document.data(as: Itinerary.self)
          } ?? []
          self.current()
        }
    }
  
  func current() {
    for itinerary in itineraries {
      if itinerary.isCurrent {
        currentItinerary = itinerary
      }
    }
  }
}
