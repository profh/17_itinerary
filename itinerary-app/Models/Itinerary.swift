//
//  Itinerary.swift
//  itinerary-app
//
//  Created by jhou on 10/17/23.
//

import SwiftUI

struct Itinerary: Identifiable, Codable, Comparable {
  
  var id: UUID
  var location: String // ie "Pittsburgh"
  var img: String? // link to image, either external or stored on firebase
  var isCurrent: Bool // is it the current itinerary?
  var days: [Day]?
  var lastEditDate: Date // last edit date
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case id
    case location
    case img
    case isCurrent
    case days
    case lastEditDate
  }
  
  static func < (lhs: Itinerary, rhs: Itinerary) -> Bool {
    lhs.lastEditDate > rhs.lastEditDate
  }
  
  static func == (lhs: Itinerary, rhs: Itinerary) -> Bool {
    lhs.lastEditDate == rhs.lastEditDate
  }
}

