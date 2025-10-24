//
//  FoodTagsView.swift
//  itinerary-app
//
//  Created by Mitun Adenuga on 12/6/23.
//

import SwiftUI

struct FoodTagsView: View {
    var quiz: Quiz
    @State var bestDestination: CityDestination
    @State private var selectedTags: Set<String> = []
    
    var foodTags = ["Asia", "Taiwanese", "Cafe", "Bar", "International", "Pub", "Healthy", "Steakhouse", "Thai", "Japanese", "Sushi", "Italian", "Seafood"]
    
    var body: some View {
        ZStack {
            // Gradient background covering the upper half of the screen
            LinearGradient(
                gradient: Gradient(colors: [Color(.colorGreenMedium), .clear]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 10) {
                // Text above the multiselect
                Text("Select the food tags you would like: ")
                    .foregroundColor(.white)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(10)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .offset(y: -20) // Adjust the vertical offset as needed
                
                // Multi-select list with rounded edges
                List(foodTags, id: \.self) { tag in
                    Toggle(tag, isOn: Binding(
                        get: {
                            self.selectedTags.contains(tag)
                        },
                        set: { _ in
                            if self.selectedTags.contains(tag) {
                                self.selectedTags.remove(tag)
                            } else {
                                self.selectedTags.insert(tag)
                            }
                        }
                    ))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.customLightTan))
                }
                .listStyle(PlainListStyle()) // Remove default list style
                .frame(width: 280) // Adjust the width as needed
                .padding(.horizontal, 20)
                
                // Next button
                NavigationLink(destination: ActivityTagsView(quiz: quiz, bestDestination: bestDestination)) {
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
                .simultaneousGesture(TapGesture().onEnded {
                    // Access the selected tags using self.selectedTags
                    print("Selected tags: \(self.selectedTags)")
                    selectedTags = quiz.foodTags
                })
                
                Spacer()
            }
        }
    }
}

