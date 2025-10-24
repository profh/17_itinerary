//
//  WeatherQuestionView.swift
//  itinerary-app
//
//  Created by Mitun Adenuga on 11/2/23.
//

/*
import SwiftUI

struct WeatherQuestionView: View {
    var quiz: Quiz
    
    @State private var weather = Weather.cold
    @State private var selectedWeather = Weather.cold // Default selection
    
    
    var body: some View {
        ZStack {
            Color(.colorGreenMedium)
            VStack {
                Text("What type of weather do you want? ")
                    .padding(.bottom, 10)
                Picker("Weather Type", selection: $selectedWeather) {
                    ForEach(Weather.allCases, id: \.self) { weatherType in
                        Text(weatherType.rawValue).tag(weatherType)
                    }
                }
                .pickerStyle(.wheel) // You can use other styles as well
                
              
              NavigationLink(destination: CityTypeView(quiz: quiz)) {
                  Text("Next")
                      .font(.subheadline)
                      .fontWeight(.medium)
                      .foregroundColor(.white)
                      .frame(maxWidth: .infinity)
                      .padding()
                      .background(Color("AccentColor"))
                      .cornerRadius(20)
                      .frame(width: 200, height: 300)
              }.simultaneousGesture(TapGesture().onEnded{
                quiz.weather = selectedWeather
                quiz.weatherMatchUpdate(weather: selectedWeather, points: 1)
              })

            }
        }
        
    }
} */

/*
import SwiftUI

struct WeatherQuestionView: View {
    var quiz: Quiz
    
    @State private var weather =  Quiz.Weather.cold
    @State private var selectedWeather = Quiz.Weather.cold // Default selection
    
    
    var body: some View {
        ZStack {
            Color(.colorGreenMedium)
            VStack {
                Text("What type of weather do you want? ")
                    .padding(.bottom, 10)
                Picker("Weather Type", selection: $selectedWeather) {
                    ForEach(Quiz.Weather.allCases, id: \.self) { weatherType in
                        Text(weatherType.rawValue).tag(weatherType)
                    }
                }
                .pickerStyle(.wheel) // You can use other styles as well
                
                
                NavigationLink(destination: CityTypeView(quiz: quiz)) {
                    Text("Hot")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("AccentColor"))
                        .cornerRadius(20)
                        .frame(width: 200, height: 300)
                }.simultaneousGesture(TapGesture().onEnded{
                    quiz.weather = selectedWeather
                })
                
                
            }
        }
        
    }
}
*/
// new code but need to make sure it updates weather correctly
import SwiftUI

struct WeatherQuestionView: View {
    var quiz: Quiz
    @State private var shadowColor: Color = .customOrange
    @State private var shadowRadius: CGFloat = 8
    @State private var shadowX: CGFloat = 20
    @State private var shadowY: CGFloat = 0
    @State private var selectedWeather = Weather.cold // Default selection
    
    var body: some View {
        ZStack {
                    // Gradient background covering the upper half of the screen
                    LinearGradient(
                        gradient: Gradient(colors: [Color(.colorGreenMedium), .clear]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                
                ZStack {
                    // Bigger rounded rectangle as a background with stroke
                        RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(Color.colorGreenMedium)
                        .overlay(
                        RoundedRectangle(cornerRadius: 30)
                        .stroke(lineWidth: 0) // Adjust the thickness of the stroke
                        .foregroundColor(Color.customBlush) // Stroke color
                            //.shadow(color: .customBlush, radius: 5, x:  2, y: 2)
                        )
                        .frame(width: 320, height: 190)
                    // define the shadow using the state variables from earlier
                                           .shadow(color: shadowColor, radius: shadowRadius, x: shadowX, y: shadowY)
                    
                    RoundedRectangle(cornerRadius: 30)
                                           .foregroundColor(Color.customLightTan.opacity(0.5))
                                           .overlay(
                                               RoundedRectangle(cornerRadius: 30)
                                                   .stroke(lineWidth: 1) // Adjust the thickness of the border
                                                   .foregroundColor(Color.customOrange) // Border color
                                                .shadow(color: .customOrange, radius: 3, x:  2, y: 2)
                                           )
                                           .frame(width: 280, height: 130) // Adjust size accordingly
                    
                    Spacer()
                    // Text with thick rounded border
                    Text("What type of weather would you like?")
                        .font(.system(size: 20))
                        //.foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .fontWeight(.medium)
                        .padding()
                        .frame(width: 300, height: 150)
                    
                    Divider()
                        .background(Color.customOrange)
                        .frame(width: 400, height: 2)
                        .offset(y: 300) // Adjust the offset to position the divider
                    
                    
                    
                }
                Spacer()
               
                VStack(spacing:40) {
                    HStack {
                        ForEach(Weather.allCases, id: \.self) {
                            weatherType in
                            Button(action: {
                                selectedWeather = weatherType
                            }) {
                                Text(weatherType.toString())
                                    .font(.title)
                                    .foregroundColor(selectedWeather == weatherType ? .white : .black)
                                    .padding()
                                    .background(selectedWeather == weatherType ? Color("AccentColor") : Color("ButtonBackground"))
                                    .cornerRadius(10)
                                
                            }
                            
                        }
                        
                    }
                }
                .padding(.top, 60)
                
                Spacer()
                
                NavigationLink(destination: CityTypeView3(quiz: quiz)) {
                    Text("Next")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("AccentColor"))
                        .cornerRadius(20)
                        .frame(width: 200, height: 300)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    quiz.weather = selectedWeather
                })
            }
        }
    }
}
