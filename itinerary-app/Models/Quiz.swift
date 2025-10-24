//
//  Quiz.swift
//  itinerary-app
//
//  Created by Mitun Adenuga on 11/1/23.
//

import Foundation
import SwiftUI

// should i create a question list or struct if i have a list would i just pass it into each of the structs?
// next button indicates the value that should be stored in that data structure
// or make it a global variable

// this is the struct for all answers after the location has been determined
/* struct QuizLocationAnswers {
    var continent: Continent
    var weather: Weather
    var city_type: City
}

// this is the struct for all answers after the location has been determined
struct QuizActivityAnswers {
    var location: String
    var activityTags: [String] = []
    var activitiesChosen: [Event] = []
    var foodTags: [String] = []
    var foodChosen: [Event] = []
}

enum Weather: String {
    case hot
    case cold
    case warm
}

enum Continent: String {
    case North_America
    case South_America
    case Africa
    case Asia
    case Antarctica
    case Europe
    case Australia
}

enum City: String {
    case island
    case metropolitan_city
    case desert
    case nature_reserve
    // add more cases
} */
struct QuizQuestion {
    let type: QuizQuestionType
    let question: String
    let answerChoices: [String]
}

// different types for the questions that have to do with location and then those that have to do with the activity tags and food
enum QuizQuestionType {
    case location
    case activity
}

extension Weather {
    func toString() -> String {
        switch self {
        case .hot:
            return "Hot"
        case .cold:
            return "Cold"
        case .warm:
            return "Warm"
        }
        
    }
}



//toString for view in city type
extension CityType {
    func toString() -> String {
        switch self {
        case .desert:
            return "Desert"
        case .coastal:
            return "Coastal"
        case .natureReserve:
            return "Nature Reserve"
        case .modern:
          return "modern"
        case .historical:
          return "historical"
        }
        
    }
}


extension Continent{
  func toString() -> String {
      switch self {
      case .northAmerica:
          return "North America"
      case .southAmerica:
        return "South America"
      case .africa:
        return "Africa"
      case .asia:
        return "Asia"
      case .antarctica:
        return "Antarctica"
      case .europe:
        return "Europe"
      case .australia:
        return "Australia"
      }
  }
  
}
// these are the only options that a user can select for the continent
enum Continent: String, CaseIterable {
    case northAmerica
    case southAmerica
    case africa
    case asia
    case antarctica
    case europe
    case australia
}

enum Weather: String, CaseIterable, Identifiable {
    case hot
    case warm
    case cold
    
    var id: String { rawValue }
}

enum CityType: String, CaseIterable, Identifiable {
    case modern
    case historical
    case coastal
    case desert
    case natureReserve
  

    var id: String { rawValue }
    
    var imageName: String {
           switch self {
           case .desert: return "dubai"
           case .natureReserve: return "nature"
           case .modern: return "big_city"
           case .historical: return "history"
           case .coastal: return "island"
               
           }
       }
}


// the questions variable will be an array of all the quiz questions since they wil always be the same
class Quiz {
    var questions: [QuizQuestion]? = []
    var duration: Int?
    var continent: Continent?
    var weather: Weather?
    var cityType: CityType?
    var foodTags: Set<String> = []
    var activityTags: Set<String> = []
    var continentMatching: Dictionary<String, [CityDestination]>
    var weatherMatching: Dictionary<String, [CityDestination]>
    var cityTypeMatching: Dictionary<String, [CityDestination]>
    var destinationPoints: Dictionary<CityDestination, Int>?
  init(questions: [QuizQuestion]? = nil, duration: Int? = nil, continent: Continent? = nil, weather: Weather? = nil, cityType: CityType? = nil) {
    self.questions = questions
    self.duration = duration
    self.continent = continent
    self.weather = weather
    self.cityType = cityType
    self.continentMatching = Dictionary<String, [CityDestination]>()
    self.weatherMatching = Dictionary<String, [CityDestination]>()
    self.cityTypeMatching = Dictionary<String, [CityDestination]>()
    self.destinationPoints = nil
    destinationPoints = LocationRepository.locationRepository.mapDestinations(quiz: self)
//    print(destinationPoints)
  }
  
  func resetDestinationPoints() {destinationPoints = LocationRepository.locationRepository.mapDestinations(quiz: self)}
  
  func continentMatchUpdate(continent: Continent, points: Int) {
    continentMatching[continent.toString()]?.forEach {
      destination in
      destinationPoints?[destination, default: 0] += points
      print("Updated \(destination.name) for the continent")
//      print(destinationPoints?[destination])
    }
//    print(destinationPoints)
  }
  func weatherMatchUpdate(weather: Weather, points: Int) {
    weatherMatching[weather.rawValue]?.forEach {
      destination in
      print("Updated \(destination.name) for the weather")
      destinationPoints?[destination, default: 0] += points
    }
//    print(destinationPoints)
  }
  func cityTypeUpdate(cityType: CityType, points: Int) {
    cityTypeMatching[cityType.toString()]?.forEach {
      destination in
      print("Updated \(destination.name) for the continent")
      destinationPoints?[destination, default: 0] += points
    }
//    print(destinationPoints)
  }
  
  func getBestDestination() -> CityDestination? {
    let sortedByValueDictionary = destinationPoints?.sorted { $0.1 > $1.1 }
    if let sortedByValueDictionary = sortedByValueDictionary {
      if let firstOne = sortedByValueDictionary.first {
        let score = firstOne.1
        var possibleDestinations: [CityDestination] = []
        for val in sortedByValueDictionary {
          if val.value >= score {
            possibleDestinations.append(val.key)
          }
        }
        print(possibleDestinations)
        return possibleDestinations.randomElement()
      }
    }
    return nil
  }
}
