//
//  CardView.swift
//  itinerary-app
//
//  Created by Mitun Adenuga on 11/4/23.
//


import SwiftUI

struct CardView: View {
    var quiz: Quiz = Quiz()
    var body: some View {
      
        NavigationView {
            ZStack {
                CustomBackgroundView()
                
                VStack {
                    // MARK: - HEADER
                    VStack {
                        Text("With travel suggestions tailored just for you...Journi finds you the perfect destination.")
                            //.multilineTextAlignment(.center)
                            .italic()
                            .foregroundColor(.customBlush)
                    } // end of header
                    .padding(.horizontal, 30)
                    
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(colors: [
                                    .customBlush,
                                    .customTan
                                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .frame(width: 270, height: 270)
                        Image("flight")
                            .resizable()
                            .scaledToFit()
                    }
                    
                    //MARK: - FOOTER
                    VStack {
                        Text("If you're still unsure...")
                            .multilineTextAlignment(.center)
                            .italic()
                            .foregroundColor(.customBlush)
                        NavigationLink(
                          destination: DurationQuestionView(quiz: quiz)) {
                                Text("Take the Quiz")
                                    .font(.subheadline)
                                    .fontWeight(.light)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color("AccentColor"))
                                    .cornerRadius(20)
                            }  .simultaneousGesture(TapGesture().onEnded{
                              quiz.resetDestinationPoints()
                            })

                    }
                    .frame(width: 170, height: 100)
                }
                .padding()
                //.frame(width: buttonWidth, height: 80)
                
                
            } // the frame for the card itself
            .frame(width: 340, height: 600)
        }
    }
}

