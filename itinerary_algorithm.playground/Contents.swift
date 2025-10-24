import Foundation

// built-in structs
struct QuizLocationAnswers{
    var continent: String
    var weather: String
    var type_of_city: String
    var duration: Int
    
    enum CodingKeys: String, CodingKey {
        case continent
        case weather
        case type_of_city
    }
}


enum EventType: String, Codable {
    case restaurant
    case attraction
    case geo
}

struct Event: Identifiable, Codable {
  var id: UUID
  var name: String
  var type: EventType
  var description: String?
  var img: String?
  var latitude: Double?
  var longitude: Double?
  var timeStart: String?
  var timeEnd: String?
  var url: String?
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
  }
}

struct Day: Identifiable, Codable {
  
  var id: UUID
  var dayNumber: Int
  var events: [Event]?
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case id
    case dayNumber
    case events
  }
}

struct Itinerary: Identifiable, Codable, Comparable {
  
  var id: UUID
  var location: String
  var img: String?
  var isCurrent: Bool
  var days: [Day]?
  var lastEditDate: Date
  
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
    lhs.lastEditDate < rhs.lastEditDate
  }
  
  static func == (lhs: Itinerary, rhs: Itinerary) -> Bool {
    lhs.lastEditDate == rhs.lastEditDate
  }
}



// structs required by algorithm / api calls

// structs for api calls (nearby search)
struct Answer: Decodable{
  let data: [Location]
  
  enum CodingKeys: String, CodingKey{
    case data = "data"
  }
}

struct Location: Decodable {
  let id: String
  let name: String
  let address: Address
  
  enum CodingKeys: String, CodingKey {
    case id = "location_id"
    case name = "name"
    case address = "address_obj"
  }
}

struct Address: Decodable{
  let street1: String?
  let street2: String?
  let city: String?
  let state: String?
  let country: String
  let address_string: String
  
  enum CodingKeys: String, CodingKey{
    case street1 = "street1"
    case street2 = "street2"
    case city = "city"
    case state = "state"
    case country = "country"
    case address_string = "address_string"
  }
}

struct CityDestination {
    var name: String
    var latitude: Double
    var longitude: Double
    var weather: String
    var cityTypes: [String]
    var continent: String
}



let cityDestinations = [
    CityDestination(name: "Paris", latitude: 48.8566, longitude: 2.3522, weather: "warm", cityTypes: ["modern", "historical"], continent: "Europe"),
    CityDestination(name: "Cairo", latitude: 30.0444, longitude: 31.2357, weather: "hot", cityTypes: ["historical"], continent: "Africa"),
    CityDestination(name: "New York", latitude: 40.7128, longitude: -74.0060, weather: "warm", cityTypes: ["modern", "coastal"], continent: "North America"),
    CityDestination(name: "Tokyo", latitude: 35.6895, longitude: 139.6917, weather: "warm", cityTypes: ["modern", "coastal"], continent: "Asia"),
    CityDestination(name: "Sydney", latitude: -33.8688, longitude: 151.2093, weather: "warm", cityTypes: ["modern", "coastal"], continent: "Australia"),
    CityDestination(name: "Rio de Janeiro", latitude: -22.9068, longitude: -43.1729, weather: "hot", cityTypes: ["coastal"], continent: "South America"),
    CityDestination(name: "Moscow", latitude: 55.7558, longitude: 37.6173, weather: "cold", cityTypes: ["modern", "historical"], continent: "Europe"),
    CityDestination(name: "Cape Town", latitude: -33.9249, longitude: 18.4241, weather: "warm", cityTypes: ["coastal", "historical"], continent: "Africa"),
    CityDestination(name: "London", latitude: 51.5074, longitude: -0.1278, weather: "cold", cityTypes: ["modern", "historical"], continent: "Europe"),
    CityDestination(name: "Vancouver", latitude: 49.2827, longitude: -123.1207, weather: "cold", cityTypes: ["modern", "coastal"], continent: "North America")
]

func findBestDestination(for quizResult: QuizLocationAnswers, from cityDestinations: [CityDestination]) -> CityDestination? {
    // Filter the destinations based on the continent
    let continentMatchedDestinations = cityDestinations.filter { $0.continent == quizResult.continent }
    
    // Filter the destinations based on the weather
    let weatherMatchedDestinations = continentMatchedDestinations.filter { $0.weather == quizResult.weather }
    
    // Filter the destinations based on the city type
    // Since cityTypes is an array, we check if the array contains the quiz result's typeOfCity
    let typeMatchedDestinations = weatherMatchedDestinations.filter { $0.cityTypes.contains(quizResult.type_of_city) }
    
    // Return the first destination that matches all criteria, or nil if there's no match
    return typeMatchedDestinations.first
}


func generateEvent_for_day(attraction_list: [String], geos_list: [String], restaurant_list: [String], daynumber: Int) -> Day{
    let Event1 = Event(id: UUID(), name: attraction_list[daynumber] , type: .attraction)
    let Event2 = Event(id: UUID(), name: geos_list[daynumber] , type: .geo)
    let Event3 = Event(id: UUID(), name: restaurant_list[daynumber] , type: .restaurant)
    
    let Dayplan = Day(id: UUID(), dayNumber: daynumber, events: [Event1, Event2, Event3])
    
    return Dayplan
}


func generate_itinerary(attrac: [String], geos: [String], restaurant: [String], daynumber: Int, location: String) -> Itinerary {
    var dayplan: [Day] = []
    for i in 0...daynumber {
        dayplan.append(generateEvent_for_day(attraction_list: attrac, geos_list: geos, restaurant_list: restaurant, daynumber: i))
    }
    let Itinerary = Itinerary(id: UUID(), location: location, isCurrent: true, days:dayplan,  lastEditDate: Date())
    return Itinerary
}


let quizResult = QuizLocationAnswers(continent: "Asia", weather: "warm", type_of_city: "modern", duration: 3)


class DataManager {
    static let shared = DataManager() // Singleton instance
    private var listofid: [String] = [] // Private storage for IDs
    private var listofname: [String] = [] //Private storage for names
    
    
    private init() {} // Private initializer to ensure singleton usage
    
    func fetchAndStoreIDs(from urlString: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Error: Invalid URL")
            completion(false)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(false)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Error: Invalid HTTP response")
                completion(false)
                return
            }

            guard let data = data else {
                print("Error: No data to decode")
                completion(false)
                return
            }

            guard let answer = try? JSONDecoder().decode(Answer.self, from: data) else {
                print("Error: Couldn't decode data into Answer")
                completion(false)
                return
            }

            self?.listofid.removeAll() // Clear any old IDs
            self?.listofname.removeAll()
            for location in answer.data {
                self?.listofid.append(location.id)
                self?.listofname.append(location.name)
            }
            
            completion(true) // Indicates success
        }
        
        task.resume() // Start the network request
    }
    
    // Function to retrieve stored IDs
    func getStoredIDs() -> [String] {
        return listofid
    }
    
    func getStoredNames() -> [String]{
        return listofname
    }
}








if let bestDestination = findBestDestination(for: quizResult, from: cityDestinations) {
    print(bestDestination.latitude)
    print(bestDestination.longitude)
    print("The best destination for you is: \(bestDestination.name)")
    
    let key = "547B30F2C5CF4458B82FAC44F069D0FA"
    let latitude = String(bestDestination.latitude)
    let longtitude = String(bestDestination.longitude)
    let latlong = latitude + "," + longtitude
    
    let basicqueryurl = "https://api.content.tripadvisor.com/api/v1/location/nearby_search?latLong=\(latitude)%2C\(longtitude)&key=547B30F2C5CF4458B82FAC44F069D0FA&language=en"
    
    let attractionsurl =
        "https://api.content.tripadvisor.com/api/v1/location/nearby_search?latLong=\(latitude)%2C\(longtitude)&key=547B30F2C5CF4458B82FAC44F069D0FA&category=attractions&language=en"
    
    let geosurl =      "https://api.content.tripadvisor.com/api/v1/location/nearby_search?latLong=\(latitude)%2C\(longtitude)&key=547B30F2C5CF4458B82FAC44F069D0FA&category=geos&language=en"
    
    let restauranturl = "https://api.content.tripadvisor.com/api/v1/location/nearby_search?latLong=\(latitude)%2C\(longtitude)&key=547B30F2C5CF4458B82FAC44F069D0FA&category=restaurants&language=en"
    
    
    

    let semaphore1 = DispatchSemaphore(value: 0)
    
    var attractions: [String] = []
    // get the id list for all the attraction activities
    DataManager.shared.fetchAndStoreIDs(from: attractionsurl) { success in
        if success {
            let ids = DataManager.shared.getStoredIDs()
            
            // Now you have the IDs and can use them
            print("Stored IDs: \(ids)")
            let names = DataManager.shared.getStoredNames()
            print("Stored Names: \(names)")
            attractions = names
        } else {
            print("Failed to fetch IDs (attractions).")
        }
        semaphore1.signal()
    }
    semaphore1.wait() // Wait for the signal
    print(attractions)
    
    
    var geos: [String] = []
    let semaphore2 = DispatchSemaphore(value: 0)
    DataManager.shared.fetchAndStoreIDs(from: geosurl) { success in
        if success {
            let ids = DataManager.shared.getStoredIDs()
            // Now you have the IDs and can use them
            print("Stored IDs: \(ids)")
            let names = DataManager.shared.getStoredNames()
            geos = names
            print("Stored Names: \(names)")
        } else {
            print("Failed to fetch IDs (geos).")
        }
        semaphore2.signal()
    }
    semaphore2.wait() // Wait for the signal
    print(geos)
    

    var restaurants: [String] = []
    let semaphore3 = DispatchSemaphore(value: 0)
    DataManager.shared.fetchAndStoreIDs(from: restauranturl) { success in
        if success {
            let ids = DataManager.shared.getStoredIDs()
            // Now you have the IDs and can use them
            print("Stored IDs: \(ids)")
            let names = DataManager.shared.getStoredNames()
            restaurants = names
            print("Stored Names: \(names)")
        } else {
            print("Failed to fetch IDs (restaurants).")
        }
        semaphore3.signal()
    }
    semaphore3.wait()
    print(restaurants)
    

    
    let test_itinerary = generate_itinerary(attrac: attractions, geos: geos, restaurant: restaurants, daynumber: quizResult.duration, location: bestDestination.name)
    
    print(test_itinerary)
    
    
} else {
    print("We could not find a destination that matches all your preferences.")
}






