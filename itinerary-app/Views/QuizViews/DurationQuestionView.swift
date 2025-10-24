//
//  DurationQuestion.swift
//  itinerary-app
//
//  Created by Mitun Adenuga on 11/2/23.
//

//will need to revisit because need to put days in a varibale for the itinerary to know to make an itinerary for those amount of days
/* import SwiftUI

struct DurationQuestionView: View {
    var quiz: Quiz
    
    @State private var days = 0
    
    var body: some View {
            ZStack {
                Color(.colorGreenMedium)
                VStack {
                    Text("How long would you like your vacation to be?")
                        .font(.subheadline)
                        .padding(.top, 5) // Adjust top padding
                    Stepper("\(days) days", value: $days, in: 1...31)
                        .padding(.bottom, 10) // Adjust bottom padding
                  NavigationLink(destination: ContinentQuestionView(quiz: quiz)) {
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
                    quiz.duration = days
                  })

                }
            }
    }
} */

import SwiftUI

struct DurationQuestionView: View {
    var quiz: Quiz
    @State private var shadowColor: Color = .customOrange
    @State private var shadowRadius: CGFloat = 8
    @State private var shadowX: CGFloat = 20
    @State private var shadowY: CGFloat = 0
    @State private var days = 1
    
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
                    Text("How long would you like your vacation to be?")
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
                        Stepper("\(days) \(days == 1 ? "day" : "days")", value: $days, in: 1...7)
                            .padding(.bottom, 10) // Adjust bottom padding
                            .frame(width: 200)
                    }
                }
                .padding(.top, 60)
                
               
                
                Spacer()
                
                NavigationLink(destination: ContinentQuestionView(quiz: quiz)) {
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
                    quiz.duration = days
                })
            }
        }
    }
}




    
