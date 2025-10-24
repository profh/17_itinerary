//
//  ContentView.swift
//  itinerary-app
//
//  Created by jhou on 10/16/23.
//

import SwiftUI
import Combine
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import AVKit
struct HomeView: View {
  @ObservedObject var itineraryRepository = ItineraryRepository.itineraryRepository
  @ObservedObject var loc = LocationRepository.locationRepository
  @State var player = AVPlayer(url: Bundle.main.url(forResource: "home_screen", withExtension: "mov")!)
  let video: (player: AVPlayer, looper: AVPlayerLooper)  = {
          let videoURL = Bundle.main.url(forResource: "home_screen", withExtension: "mov")!
          let asset = AVAsset(url: videoURL)
          let item = AVPlayerItem(asset: asset)
          let queuePlayer = AVQueuePlayer(playerItem: item)
          let playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: item)
          queuePlayer.play()
          queuePlayer.isMuted = true
          return (queuePlayer, playerLooper)
      }()
  var body: some View {
    let current = itineraryRepository.currentItinerary
    NavigationView {
      ZStack {
        VideoPlayer(player: video.player)
                        .disabled(true) // Hides iOS video controls
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .onAppear {
                          video.player.isMuted = true
                          video.player.play()
                        }
                        .onDisappear{
                          video.player.pause() }
                        .opacity(0.5)
        VStack {
          Spacer()
          Text("Journi")
                  .fontWeight(.bold)
                  .font(.system(size: 30))
                  .foregroundStyle(LinearGradient(colors: [.customTan, .customBlush], startPoint: .top, endPoint: .bottom))
          Spacer().frame(height: 50)
          VStack(alignment: .leading) {
            Text("Current Itinerary").font(.title2).fontWeight(.bold)
            if let current {
              ItineraryNavView(itinerary: current, isCurrent: true, saved: true/*, itineraryRepository: self.itineraryRepository*/)
            }
            else {
              ZStack {
                // Gradient on top of the image
                Rectangle()
                    .fill(lightBlueColor)
                    .frame(width: 340, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                // Text within the button
                HStack {
                  Text("Set an itinerary as your current one!").frame(alignment: .leading)
                    .fontWeight(.bold).foregroundColor(Color.black)
                    .font(.title3)
                }.padding(10)
                  Spacer()
              }.frame(maxWidth: 340, maxHeight: 200, alignment: .leading)
            }
          }
          NavigationLink(destination: DurationQuestionView(quiz: Quiz())) {
            ZStack {
              Rectangle()
                .fill(Color.gray)
                  .frame(width: 340, height: 100)
                  .clipShape(RoundedRectangle(cornerRadius: 20))
                  .opacity(0.7)
              HStack {
                Image("flight")
                    .resizable()
                    .scaledToFit().frame(width: 100, height: 100)
                Text("Create New Itinerary").foregroundColor(Color.black)
              }
            }
          }
          
          
          Spacer()

        }
      }
    }
  }
}

#Preview {
    HomeView()
}

