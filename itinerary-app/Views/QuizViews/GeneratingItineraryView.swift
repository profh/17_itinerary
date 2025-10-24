//
//  GeneratingItineraryView.swift
//  itinerary-app
//
//  Created by jhou on 11/9/23.
//

import SwiftUI
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

//struct to get the coord of position
struct Location_coord: Decodable {
    let latitude: String
    let longitude: String
    let url: String
  
  enum CodingKeys: String, CodingKey {
      case latitude = "latitude"
      case longitude = "longitude"
      case url = "web_url"
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

//structures for fetching images:
struct Root: Decodable {
    let data: [DataItem]
}

// Data item structure
struct DataItem: Decodable {
    let id: Int
    let isBlessed: Bool
    let caption: String
    let publishedDate: String
    let images: Images
    let album: String
    let source: Source
    let user: User

    enum CodingKeys: String, CodingKey {
        case id
        case isBlessed = "is_blessed"
        case caption
        case publishedDate = "published_date"
        case images
        case album
        case source
        case user
    }
}

// Images structure
struct Images: Decodable {
    let thumbnail: ImageSize
    let small: ImageSize
    let medium: ImageSize
    let large: ImageSize
    let original: ImageSize
}

// Image size structure
struct ImageSize: Decodable {
    let height: Int
    let width: Int
    let url: String
}

// Source structure
struct Source: Decodable {
    let name: String
    let localizedName: String

    enum CodingKeys: String, CodingKey {
        case name
        case localizedName = "localized_name"
    }
}

// User structure
struct User: Decodable {
    let username: String
}


//func generateEvent_for_day(attraction_list: [String], geos_list: [String], restaurant_list: [String], daynumber: Int, attrac_id:[String], geos_id: [String], restaurant_id: [String]) -> Day{
//    let target_attrc_id = attrac_id[daynumber]
//    let target_geo_id = geos_id[daynumber]
//    let target_restaurant_id = restaurant_id[daynumber]
//    
//    
//    var attrc_img = ""
//    var geo_img = ""
//    var res_img = ""
//    
//    var attrc_coord: (String, String) = ("0", "0")
//    var geo_coord: (String, String) = ("0", "0")
//    var res_coord: (String, String) = ("0", "0")
//    
//    var attrc_url = ""
//    var geo_url = ""
//    var res_url = ""
//    
//    
//    let semaphore100 = DispatchSemaphore(value: 0)
//  
//    DataManager.shared.fetchImage(from: target_attrc_id) {
//        result in
//        //print(result)
//        attrc_img = result
//        semaphore100.signal()
//    }
//    semaphore100.wait()
//    
//    let semaphore101 = DispatchSemaphore(value: 0)
//    DataManager.shared.fetchImage(from: target_geo_id) {
//        result in
//        //print(result)
//        geo_img = result
//        semaphore101.signal()
//    }
//    semaphore101.wait()
//    
//    let semaphore102 = DispatchSemaphore(value: 0)
//    DataManager.shared.fetchImage(from: target_restaurant_id) {
//        result in
//        //print(result)
//        res_img = result
//        semaphore102.signal()
//    }
//    semaphore102.wait()
//    
//    let semaphore103 = DispatchSemaphore(value: 0)
//    DataManager.shared.fetchCoord_and_url(from: target_attrc_id) {
//        (lat,lon,url) in
//        //print(result)
//        attrc_coord = (lat,lon)
//        attrc_url = url
//        semaphore103.signal()
//    }
//    semaphore103.wait()
//    
//    let semaphore104 = DispatchSemaphore(value: 0)
//    DataManager.shared.fetchCoord_and_url(from: target_geo_id) {
//        (lat,lon,url) in
//        //print(result)
//        geo_coord = (lat,lon)
//        geo_url = url
//        semaphore104.signal()
//    }
//    semaphore104.wait()
//    
//    let semaphore105 = DispatchSemaphore(value: 0)
//    DataManager.shared.fetchCoord_and_url(from: target_restaurant_id) {
//        (lat,lon,url) in
//        //print(result)
//        res_coord = (lat,lon)
//        res_url = url
//        semaphore105.signal()
//    }
//    semaphore105.wait()
//    
//    var d1to2 = calculateDistance(from: attrc_coord, to: geo_coord)
//    var d2to3 = calculateDistance(from: geo_coord, to: res_coord)
//    
//
//    let Event1 = Event(
//        id: UUID(),
//        name: attraction_list[daynumber],
//        img: attrc_img == "" ? nil : attrc_img,
//        type: .attraction, url: attrc_url
//    )
//    
//    let Event1to2 = Event(
//        id: UUID(),
//        name: "Distance: \(d1to2 ?? "unknown")km",
//        type: .travel
//    )
//    
//
//    let Event2 = Event(
//        id: UUID(),
//        name: geos_list[daynumber],
//        img: geo_img == "" ? nil : geo_img,
//        type: .geo, url: geo_url
//    )
//    
//    let Event2to3 = Event(
//        id: UUID(),
//        name: "Distance: \(d2to3 ?? "unknown")km",
//        type: .travel
//    )
//
//    let Event3 = Event(
//        id: UUID(),
//        name: restaurant_list[daynumber],
//        img: res_img == "" ? nil : res_img,
//        type: .restaurant, url: res_url
//    )
//    let Dayplan = Day(id: UUID(), dayNumber: daynumber + 1, events: [Event1, Event1to2, Event2, Event2to3, Event3])
//    
//    return Dayplan
//}

func generateEvent_for_day(attraction_list: [String], geos_list: [String], restaurant_list: [String], daynumber: Int, attrac_id:[String], geos_id: [String], restaurant_id: [String]) -> Day{
    let target_attrc_id1 = attrac_id[2 * daynumber]
    let target_attrc_id2 = attrac_id[2 * daynumber + 1]
    //let target_geo_id = geos_id[daynumber]
    let target_restaurant_id1 = restaurant_id[2 * daynumber]
    let target_restaurant_id2 = restaurant_id[2 * daynumber + 1]
    
    
    var attrc_img1 = ""
    var attrc_img2 = ""
    var res_img1 = ""
    var res_img2 = ""
    
    var attrc_coord1: (String, String) = ("0", "0")
    var attrc_coord2: (String, String) = ("0", "0")
    var res_coord1: (String, String) = ("0", "0")
    var res_coord2: (String, String) = ("0", "0")
    
    var attrc_url1 = ""
    var attrc_url2 = ""
    var res_url1 = ""
    var res_url2 = ""
    
    
    let semaphore100 = DispatchSemaphore(value: 0)
  
    DataManager.shared.fetchImage(from: target_attrc_id1) {
        result in
        //print(result)
        attrc_img1 = result
        semaphore100.signal()
    }
    semaphore100.wait()
    
    let semaphore101 = DispatchSemaphore(value: 0)
    DataManager.shared.fetchImage(from: target_attrc_id2) {
        result in
        //print(result)
        attrc_img2 = result
        semaphore101.signal()
    }
    semaphore101.wait()
    
    let semaphore102 = DispatchSemaphore(value: 0)
    DataManager.shared.fetchImage(from: target_restaurant_id1) {
        result in
        //print(result)
        res_img1 = result
        semaphore102.signal()
    }
    semaphore102.wait()
    
    let semaphore103 = DispatchSemaphore(value: 0)
    DataManager.shared.fetchImage(from: target_restaurant_id2) {
        result in
        //print(result)
        res_img2 = result
        semaphore103.signal()
    }
    semaphore103.wait()
    
    
    
    let semaphore104 = DispatchSemaphore(value: 0)
    DataManager.shared.fetchCoord_and_url(from: target_attrc_id1) {
        (lat,lon,url) in
        //print(result)
        attrc_coord1 = (lat,lon)
        attrc_url1 = url
        semaphore104.signal()
    }
    semaphore104.wait()
    
    let semaphore105 = DispatchSemaphore(value: 0)
    DataManager.shared.fetchCoord_and_url(from: target_attrc_id2) {
        (lat,lon,url) in
        //print(result)
        attrc_coord2 = (lat,lon)
        attrc_url2 = url
        semaphore105.signal()
    }
    semaphore105.wait()
    
    let semaphore106 = DispatchSemaphore(value: 0)
    DataManager.shared.fetchCoord_and_url(from: target_restaurant_id1) {
        (lat,lon,url) in
        //print(result)
        res_coord1 = (lat,lon)
        res_url1 = url
        semaphore106.signal()
    }
    semaphore106.wait()
    
    let semaphore107 = DispatchSemaphore(value: 0)
    DataManager.shared.fetchCoord_and_url(from: target_restaurant_id2) {
        (lat,lon,url) in
        //print(result)
        res_coord2 = (lat,lon)
        res_url2 = url
        semaphore107.signal()
    }
    semaphore107.wait()
    
    var d1to2 = calculateDistance(from: res_coord1, to: attrc_coord1)
    var d2to3 = calculateDistance(from: attrc_coord1, to: attrc_coord2)
    var d3to4 = calculateDistance(from: attrc_coord2, to: res_coord2)
    

    let Event1 = Event(
        id: UUID(),
        name: restaurant_list[daynumber * 2],
        img: res_img1 == "" ? nil : res_img1,
        type: .restaurant, url: res_url1
    )
    
    let Event1to2 = Event(
        id: UUID(),
        name: "Distance: \(d1to2 ?? "unknown")km",
        type: .travel
    )
    

    let Event2 = Event(
        id: UUID(),
        name: attraction_list[daynumber * 2],
        img: attrc_img1 == "" ? nil : attrc_img1,
        type: .attraction, url: attrc_url1
    )
    
    let Event2to3 = Event(
        id: UUID(),
        name: "Distance: \(d2to3 ?? "unknown")km",
        type: .travel
    )

    let Event3 = Event(
        id: UUID(),
        name: attraction_list[daynumber * 2 + 1],
        img: attrc_img2 == "" ? nil : attrc_img2,
        type: .attraction, url: attrc_url2
    )
    
    let Event3to4 = Event(
        id: UUID(),
        name: "Distance: \(d3to4 ?? "unknown")km",
        type: .travel
    )
    
    let Event4 = Event(
        id: UUID(),
        name: restaurant_list[daynumber * 2 + 1],
        img: res_img2 == "" ? nil : res_img2,
        type: .restaurant, url: res_url2
    )
    
    
    
    let Dayplan = Day(id: UUID(), dayNumber: daynumber + 1, events: [Event1, Event1to2, Event2, Event2to3, Event3, Event3to4, Event4])
    
    return Dayplan
}




func calculateDistance(
    from coordinates1: (latitude: String, longitude: String),
    to coordinates2: (latitude: String, longitude: String)
) -> String? {
    // Radius of the Earth in kilometers
    let earthRadius = 6371.0
    
    // Convert latitude and longitude strings to doubles
    if let lat1 = Double(coordinates1.latitude),
       let lon1 = Double(coordinates1.longitude),
       let lat2 = Double(coordinates2.latitude),
       let lon2 = Double(coordinates2.longitude) {
        
        // Convert degrees to radians
        let lat1Rad = lat1 * .pi / 180
        let lon1Rad = lon1 * .pi / 180
        let lat2Rad = lat2 * .pi / 180
        let lon2Rad = lon2 * .pi / 180
        
        // Haversine formula
        let dLat = lat2Rad - lat1Rad
        let dLon = lon2Rad - lon1Rad
        let a = sin(dLat / 2) * sin(dLat / 2) + cos(lat1Rad) * cos(lat2Rad) * sin(dLon / 2) * sin(dLon / 2)
        let c = 2 * atan2(sqrt(a), sqrt(1 - a))
        let distance = earthRadius * c
        
        // Convert the distance to a string
        let distanceString = String(format: "%.2f", distance) // Format to two decimal places
        
        return distanceString
    } else {
        // Invalid input, return nil
        return nil
    }
}


func generate_itinerary(attrac: [String], geos: [String], restaurant: [String], daynumber: Int, location: String, attrac_id:[String], geos_id: [String], restaurant_id: [String]) -> Itinerary {
    let itinerary_place_id = geos_id[2]
    var dayplan: [Day] = []
    for i in 0...daynumber {
        dayplan.append(generateEvent_for_day(attraction_list: attrac, geos_list: geos, restaurant_list: restaurant, daynumber: i, attrac_id: attrac_id, geos_id: geos_id, restaurant_id: restaurant_id))
    }
    
    var itinerary_img = ""
    
    let semaphore100 = DispatchSemaphore(value: 0)
    DataManager.shared.fetchImage(from: itinerary_place_id) {
        result in
        //print(result)
        itinerary_img = result
        semaphore100.signal()
    }
    semaphore100.wait()
    
    let Itinerary = Itinerary(id: UUID(), location: location, img: itinerary_img, isCurrent: false, days:dayplan,  lastEditDate: Date())
    return Itinerary
}


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
    
    func fetchImage(from location_id: String, completion: @escaping (String) -> Void) {
        let locationURL = "https://api.content.tripadvisor.com/api/v1/location/\(location_id)/photos?key=547B30F2C5CF4458B82FAC44F069D0FA&language=en"
        
        guard let url = URL(string: locationURL) else {
            print("Error: Invalid URL")
            completion("")
            return
        }
        print(locationURL)

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion("")
                return
            }

            // Assuming you're checking the response status here
            // ...

            guard let data = data else {
                print("Error: No data to decode")
                completion("")
                return
            }

            guard let answer = try? JSONDecoder().decode(Root.self, from: data) else {
                print("Error: Couldn't decode data into Answer (Image)")
                completion("")
                return
            }

            if answer.data.isEmpty {
                print(1)
                completion("")
            } else {
                print(2)
                print(answer.data[0].images.original.url)
                completion(answer.data[0].images.original.url)
            }
        }
        task.resume() // Start the network request
    }
    func fetchCoord_and_url(from location_id: String, completion: @escaping (String, String, String) -> Void) {
        let locationURL = "https://api.content.tripadvisor.com/api/v1/location/\(location_id)/details?key=547B30F2C5CF4458B82FAC44F069D0FA&language=en&currency=USD"
        
        guard let url = URL(string: locationURL) else {
            print("Error: Invalid URL")
            completion("Invalid URL", "", "")
            return
        }
        //print(locationURL)

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion("Error: \(error.localizedDescription)", "","")
                return
            }

            // Assuming you're checking the response status here
            // ...

            guard let data = data else {
                print("Error: No data to decode")
                completion("No data to decode", "", "")
                return
            }

            guard let answer = try? JSONDecoder().decode(Location_coord.self, from: data) else {
                print("Error: Couldn't decode data into Answer (Image)")
                completion("","","")
                return
            }

            if (answer.latitude.isEmpty){
                completion("","","")
            } else {
                completion(answer.latitude, answer.longitude, answer.url)
            }
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


func generateEventList (bestDestination: CityDestination, category: Int) -> ([String], [String]){
    let key = "547B30F2C5CF4458B82FAC44F069D0FA"
    let latitude = String(bestDestination.latitude)
    let longtitude = String(bestDestination.longitude)
    let latlong = latitude + "," + longtitude
    if category == 1{
        let attractionsurl =
            "https://api.content.tripadvisor.com/api/v1/location/nearby_search?latLong=\(latitude)%2C\(longtitude)&key=547B30F2C5CF4458B82FAC44F069D0FA&category=attractions&language=en"
      print(attractionsurl)
        let semaphore1 = DispatchSemaphore(value: 0)
        
        var attractions: [String] = []
        var attractions_id: [String] = []
        // get the id list for all the attraction activities
        DataManager.shared.fetchAndStoreIDs(from: attractionsurl) { success in
            if success {
                let ids = DataManager.shared.getStoredIDs()
                attractions_id = ids
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
        return (attractions, attractions_id)
    }
    else if category == 2{
        let geosurl =      "https://api.content.tripadvisor.com/api/v1/location/nearby_search?latLong=\(latitude)%2C\(longtitude)&key=547B30F2C5CF4458B82FAC44F069D0FA&category=geos&language=en"
        var geos: [String] = []
        var geos_id:[String] = []
        let semaphore2 = DispatchSemaphore(value: 0)
        DataManager.shared.fetchAndStoreIDs(from: geosurl) { success in
            if success {
                let ids = DataManager.shared.getStoredIDs()
                geos_id = ids
                // Now you have the IDs and can use them
                //print("Stored IDs: \(ids)")
                let names = DataManager.shared.getStoredNames()
                geos = names
                //print("Stored Names: \(names)")
            } else {
                print("Failed to fetch IDs (geos).")
            }
            semaphore2.signal()
        }
        semaphore2.wait() // Wait for the signal
        return (geos, geos_id)
    }
    else{
        let restauranturl = "https://api.content.tripadvisor.com/api/v1/location/nearby_search?latLong=\(latitude)%2C\(longtitude)&key=547B30F2C5CF4458B82FAC44F069D0FA&category=restaurants&language=en"
        var restaurants: [String] = []
        var restaurants_id: [String] = []
        let semaphore3 = DispatchSemaphore(value: 0)
        DataManager.shared.fetchAndStoreIDs(from: restauranturl) { success in
            if success {
                let ids = DataManager.shared.getStoredIDs()
                // Now you have the IDs and can use them
                //print("Stored IDs: \(ids)")
                let names = DataManager.shared.getStoredNames()
                restaurants = names
                restaurants_id = ids
                //print("Stored Names: \(names)")
            } else {
                print("Failed to fetch IDs (restaurants).")
            }
            semaphore3.signal()
        }
        semaphore3.wait()
        return (restaurants, restaurants_id)
    }
}


func get_coord_info(id: String) -> (String, String) {
    let semaphore110 = DispatchSemaphore(value: 0)
    var (reslat,reslong) = ("0","0")
    DataManager.shared.fetchCoord_and_url(from: id) {
        (lat,lon,url) in
        //print(result)
        (reslat,reslong) = (lat,lon)
        semaphore110.signal()
    }
    semaphore110.wait()
    return (reslat, reslong)
}



struct GeneratingItineraryView: View {
    @State private var itinerary: Itinerary? = nil
    var location: String
    var bestDestination: CityDestination
    @State private var isLoading = true
    var quiz: Quiz
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(.colorGreenMedium), .clear]),
                startPoint: .top,
                endPoint: .bottom
            )
            
            VStack {
                if isLoading {
                    PulsatingCircle()
                        .padding(.top, 30)
                } else {
                    let (attractions_origin, attractions_id_origin) = generateEventList(bestDestination: bestDestination, category: 1)
                    let (geos, geos_id) = generateEventList(bestDestination: bestDestination, category: 2)
                    let (restaurants_origin, restaurants_id_origin) = generateEventList(bestDestination: bestDestination, category: 3)
                    
                    
                    let (backupGeo, backupGeoid) = (geos[0], geos_id[0])
                    let (backupGeolat, backupGeolong) = get_coord_info(id: backupGeoid)
                    let backupDestination = CityDestination(name: backupGeo, latitude: Double(backupGeolat) ?? 0.0, longitude: Double(backupGeolong) ?? 0.0, cityType: [""])
                    
                    let (backup_attractions, backup_attractions_id) = generateEventList(bestDestination: backupDestination, category: 1)
                    let (backup_res, backup_res_id) = generateEventList(bestDestination: backupDestination, category: 3)
                    
                    
                    
                    let (backupGeo2, backupGeoid2) = (geos[1], geos_id[1])
                    let (backupGeolat2, backupGeolong2) = get_coord_info(id: backupGeoid2)
                    let backupDestination2 = CityDestination(name: backupGeo2, latitude: Double(backupGeolat2) ?? 0.0, longitude: Double(backupGeolong2) ?? 0.0, cityType: [""])
                    
                    let (backup_attractions2, backup_attractions_id2) = generateEventList(bestDestination: backupDestination2, category: 1)
                    let (backup_res2, backup_res_id2) = generateEventList(bestDestination: backupDestination2, category: 3)
                    
                    
                    
                    let attractions = attractions_origin + backup_attractions + backup_attractions2
                    let attractions_id = attractions_id_origin + backup_attractions_id + backup_attractions_id2
                    var restaurants = restaurants_origin + backup_res + backup_res2
                    var restaurants_id = restaurants_id_origin + backup_res_id + backup_res_id2
                   

                    
                    
                    
                  let itinerary = generate_itinerary(attrac: attractions, geos: geos, restaurant: restaurants, daynumber: (quiz.duration ?? 1) - 1, location: location, attrac_id: attractions_id, geos_id: geos_id, restaurant_id: restaurants_id)
                    
                    Text("Itinerary Generated!")
                        .padding(.top, 30)
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    NavigationLink(destination: ItineraryDetailView(itinerary: itinerary, saved: false)) {
                        Text("Next")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("AccentColor"))
                            .cornerRadius(20)
                            .frame(width: 200, height: 50)
                    }
                }
            }
        }
        .onAppear {
            // Simulate a delay or some asynchronous task completion
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.isLoading = false
            }
        }
    }
}

struct PulsatingCircle: View {
    @State private var pulsate = false

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color("AccentColor"), lineWidth: 4)
                .frame(width: 70, height: 70)
                .scaleEffect(pulsate ? 1.2 : 1.0)
                .opacity(pulsate ? 0.0 : 1.0)
                .animation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: false))
            
            Circle()
                .fill(Color("AccentColor"))
                .frame(width: 50, height: 50)
                .scaleEffect(pulsate ? 1.2 : 1.0)
                .opacity(pulsate ? 0.0 : 1.0)
                .animation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: false))
            
            Text("Loading your itinerary...")
                .font(.headline)
                .foregroundColor(.white)
                .offset(y: 40)
                .opacity(pulsate ? 0.0 : 1.0)
                .animation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: false))
        }
        .onAppear {
            self.pulsate.toggle()
        }
    }
}
