//
//  GivenLocationView2.swift
//  itinerary-app
//
//  Created by Mitun Adenuga on 12/7/23.
//


import SwiftUI

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

//struct CityDestination {
//    var name: String
//    var latitude: Double
//    var longitude: Double
//    var weather: String
//    var cityTypes: [String]
//    var continent: String
//}


func findBestDestination(for quizResult: QuizLocationAnswers, from cityDestinations: [CityDestination]) -> CityDestination? {
    // Filter the destinations based on the continent
    let continentMatchedDestinations = cityDestinations.filter { $0.continent == quizResult.continent }
    
    // Filter the destinations based on the weather
    let weatherMatchedDestinations = continentMatchedDestinations.filter { $0.weather == quizResult.weather }
    
    // Filter the destinations based on the city type
    // Since cityTypes is an array, we check if the array contains the quiz result's typeOfCity
    let typeMatchedDestinations = weatherMatchedDestinations.filter { $0.cityType.contains(quizResult.type_of_city) }
    
    // Return the first destination that matches all criteria, or nil if there's no match
    return typeMatchedDestinations.first
}

let cityDestinations = [
    CityDestination(name: "Rome", latitude: 41.9028, longitude: 12.4964, weather: "temperate", cityType: ["historical", "metropolitan city"], continent: "Europe"),
    CityDestination(name: "Bangkok", latitude: 13.7563, longitude: 100.5018, weather: "warm", cityType: ["modern", "metropolitan city"], continent: "Asia"),
    CityDestination(name: "Cancun", latitude: 21.1619, longitude: -86.8515, weather: "hot", cityType: ["coastal", "island"], continent: "North America"),
    CityDestination(name: "Bali", latitude: -8.3405, longitude: 115.0920, weather: "warm", cityType: ["island", "nature reserve"], continent: "Asia"),
    CityDestination(name: "Reykjavik", latitude: 64.1265, longitude: -21.8174, weather: "cold", cityType: ["modern", "coastal"], continent: "Europe"),
    CityDestination(name: "Hawaii", latitude: 20.7967, longitude: -156.3319, weather: "warm", cityType: ["island", "coastal"], continent: "North America"),
    CityDestination(name: "Kyoto", latitude: 35.0116, longitude: 135.7681, weather: "temperate", cityType: ["historical"], continent: "Asia"),
    CityDestination(name: "Dubai", latitude: 25.276987, longitude: 55.296249, weather: "hot", cityType: ["modern", "desert"], continent: "Asia"),
        // Add more destinations here...
    CityDestination(name: "Istanbul", latitude: 41.0082, longitude: 28.9784, weather: "temperate", cityType: ["historical", "metropolitan city"], continent: "Asia"),
        CityDestination(name: "Marrakech", latitude: 31.6295, longitude: -7.9811, weather: "warm", cityType: ["historical", "desert"], continent: "Africa"),
    CityDestination(name: "Auckland", latitude: -36.8485, longitude: 174.7633, weather: "temperate", cityType: ["coastal", "metropolitan city"], continent: "Australia"),
    CityDestination(name: "Amsterdam", latitude: 52.3676, longitude: 4.9041, weather: "temperate", cityType: ["historical", "metropolitan city"], continent: "Europe"),
    CityDestination(name: "Machu Picchu", latitude: -13.1631, longitude: -72.5450, weather: "temperate", cityType: ["historical", "nature reserve"], continent: "South America"),
    CityDestination(name: "Los Angeles", latitude: 34.0522, longitude: -118.2437, weather: "warm", cityType: ["modern", "coastal"], continent: "North America"),
    CityDestination(name: "Miami", latitude: 25.7617, longitude: -80.1918, weather: "hot", cityType: ["coastal", "metropolitan city"], continent: "North America"),
    CityDestination(name: "Dubai", latitude: 25.276987, longitude: 55.296249, weather: "hot", cityType: ["modern", "desert"], continent: "Asia"),
    CityDestination(name: "Maui", latitude: 20.7967, longitude: -156.3319, weather: "warm", cityType: ["island", "nature reserve"], continent: "North America"),
    CityDestination(name: "Santorini", latitude: 36.3932, longitude: 25.4615, weather: "warm", cityType: ["island", "coastal"], continent: "Europe"),
    CityDestination(name: "Kruger National Park", latitude: -24.4075, longitude: 31.3148, weather: "warm", cityType: ["nature reserve"], continent: "Africa"),
    CityDestination(name: "New Orleans", latitude: 29.9511, longitude: -90.0715, weather: "hot", cityType: ["modern", "historical"], continent: "North America"),
]


struct GivenLocationView: View {
    var quiz: Quiz
    @State private var isLoading = true
    
    var body: some View {
        let bestDestination = quiz.getBestDestination()
        
        ZStack {
            Image("flight2")
                .resizable()
                .scaledToFill()
                .opacity(0.7)
            
            VStack {
                // Your location text with increased bottom padding
                Text("Your location is:")
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.bottom, 100) // Increase the bottom padding
                
                // Given location text with increased top padding and larger white background
                Text(bestDestination?.name ?? "")
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundColor(.accentColor)
                    .background(Color.white)
                    .cornerRadius(5)
                    .frame(width: 390, height: 180) // Adjust the width and height here
                    .padding(.top, 120) // Adjust the top padding here
                
                Spacer()
                
                if let bestDestination {
                    NavigationLink(destination: FoodTagsView(quiz: quiz, bestDestination: bestDestination)) {
                        Text("Next")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("AccentColor"))
                            .cornerRadius(20)
                            .frame(width: 200) // Adjust the width here
                        
                            .padding(.bottom, 20) // Add some bottom padding for the "Next" button
                    }
                }
            }
        }
    }
}












