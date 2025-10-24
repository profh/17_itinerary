//
// CityTypeView3.swift
// itinerary-app
//
// Created by Mitun Adenuga on 11/16/23.
//
import SwiftUI
struct CityTypeView3: View {
    var quiz: Quiz
    @State private var currentIndex: Int = 0
    @State private var dragOffset: CGFloat = 0

    private let cityTypes: [CityType] = [.desert, .natureReserve, .modern, .historical, .coastal]
    private let imageTexts: [String] = [
        "A city with interesting deserts like Dubai",
        "A city with nature reserves and great adventure trails",
        "A metropolitan city full of life and entertainment",
        "A city known for its rich cultural history",
        "A city with beautiful islands like the Maldives"
    ]

    var body: some View {
        VStack {
            ZStack {
                // Background gradient and text
                LinearGradient(
                    gradient: Gradient(colors: [Color(.colorGreenMedium), .clear]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 500) // Adjust the height as needed

                Text("Slide to select the image that most resembles the type of city you'd like to visit. Once you like your decision select Next.")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .italic()
                    .multilineTextAlignment(.center)
                    .background(Color.gray.opacity(0.5)) // Add a faint grey background
                    .cornerRadius(10)
                    .offset(y: -120)

                // Image carousel with text wrapped around
                // Image carousel with text wrapped around
                ForEach(0..<cityTypes.count, id: \.self) { index in
                    VStack {
                        Image(cityTypes[index].imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 180, height: 220)
                            .cornerRadius(25)
                            .opacity(currentIndex == index ? 1.0 : 0.5)
                            .scaleEffect(currentIndex == index ? 1.2 : 0.8)
                            .onTapGesture {
                                currentIndex = index
                                dragOffset = 0
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.orange, lineWidth: currentIndex == index ? 5 : 0)
                                    .frame(width: 213, height: 260)
                            )

                        Text(imageTexts[index])
                            .foregroundColor(.white)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .padding(10)
                            .background(Color.gray.opacity(0.5)) // Add a faint grey background
                            .cornerRadius(10)
                            .italic() // Italicize the text
                            .multilineTextAlignment(.center)
                            .frame(width: 180)
                            .offset(y: currentIndex == index ? -70 : 0)
                    }
                    .offset(x: CGFloat(index - currentIndex) * 250 + dragOffset, y: 0)
                }
                .offset(y: 120)

            }
            .gesture(
                DragGesture()
                    .onEnded({ value in
                        let threshold: CGFloat = 50
                        if value.translation.width > threshold {
                            withAnimation {
                                currentIndex = max(0, currentIndex - 1)
                            }
                        } else if value.translation.width < -threshold {
                            withAnimation {
                                currentIndex = min(cityTypes.count - 1, currentIndex + 1)
                            }
                        }
                    })
            )

            Divider()
                .background(Color.customOrange)
                .frame(width: 400, height: 2)
                .offset(y: 20) // Adjust the offset to position the divider

            NavigationLink(destination: GivenLocationView(quiz: quiz)) {
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
            .offset(y: -60)
            .simultaneousGesture(TapGesture().onEnded {
                quiz.cityType = cityTypes[currentIndex]
                quiz.cityTypeUpdate(cityType: cityTypes[currentIndex], points: 1)
            })
        }
    }
}




struct CityTypeImageView: View {
  let cityType: CityType
  let quiz: Quiz
  let index: Int
  @Binding var currentIndex: Int
  @Binding var dragOffset: CGFloat
  @State private var isSelected: Bool = false
  private let cityTypes: [CityType] = [.desert, .natureReserve, .modern, .historical, .coastal]

    
  var body: some View {
    ZStack {
      Image(cityType.imageName)
        .resizable()
        .scaledToFill()
        .frame(width: 200, height: 250)
        .cornerRadius(25)
        .opacity(isSelected ? 1.0 : 0.5)
        .scaleEffect(isSelected ? 1.2 : 0.8)
        .offset(x: CGFloat(index - currentIndex) * 250 + dragOffset, y: 0)
    
    }
    .onTapGesture {
      if isSelected {
        isSelected = false
        currentIndex = -1
      } else {
        if currentIndex != -1 {
          if let previouslySelectedIndex = (0..<cityTypes.count).first(where: { cityTypes[$0] == quiz.cityType }) {
            currentIndex = previouslySelectedIndex
          }
        }
        isSelected = true
        currentIndex = index
        dragOffset = 0
      }
    }
  }
 
}
