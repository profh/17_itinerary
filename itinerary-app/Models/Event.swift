//
//  Event.swift
//  itinerary-app
//
//  Created by jhou on 10/17/23.
//

import Foundation
enum EventType: String, Codable {
    case restaurant
    case attraction
    case travel
    case geo
}

struct Event: Identifiable, Codable {
  
  var id: UUID
  var name: String // ie "McDonalds", "Eiffel Tower", "Bus"
  var description: String? // description of the event
  var img: String? // link to image, if it's an attraction
  var type: EventType // is it a meal, attraction, or travel?
  var latitude: Double? // where is it?
  var longitude: Double? // where is it?
  var timeStart: String? // what time does this event start, format flexible, currently set to hhmm
  var timeEnd: String? // what time does this event end, , format flexible, currently set to hhmm
  var url: String? // if it's travel, link to google maps page with directions
                   // if it's food, link to food location
                   // if it's attraction, link to attraction website
  var notes: String? 
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case description
    case img
    case type
    case latitude
    case longitude
    case timeStart
    case timeEnd
    case url
    case notes
  }
}
